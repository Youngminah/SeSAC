//
//  RegisterViewModel.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

typealias RegisterRequestInfo = (username: String, email: String, password: String)

final class RegisterViewModel {
    
    struct Input {
        let registerButtonTapEvent: Signal<RegisterRequestInfo>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let registerSuccessAlertAction: Driver<String>
        let toastMessageAction: Driver<String>
    }
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let registerSuccessAlertAction = PublishRelay<String>()
    private let toastMessageAction = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    private let tokenClosure: (TargetType) -> String = { _ in
        return TokenUtils.read(AppConfiguration.service, account: "accessToken") ?? ""
    }

    var provider: MoyaProvider<SesacTarget>
    
    init() {
        let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
        provider = MoyaProvider<SesacTarget>(plugins: [authPlugin])
    }
    
    func transform(input: Input) -> Output {
        input.registerButtonTapEvent
            .asObservable()
            .do { [unowned self] _ in
                self.isLoading.accept(false)
            }
            .flatMap { [unowned self] (username, email, password) -> Single<RegisterInfo.Response> in
                return self.requestRegister(username: username, email: email, password: password)
            }
            .subscribe (onNext: { [weak self] response in
                guard let self = self else { return }
                TokenUtils.create(AppConfiguration.service, account: "accessToken", value: response.jwt)
                self.isLoading.accept(true)
                self.registerSuccessAlertAction.accept("회원가입이 정상적으로 완료되었습니다.")
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.isLoading.accept(true)
                let error = error as! SessacError
                self.registerSuccessAlertAction.accept(error.errorDescription)
            })
            .disposed(by: disposeBag)
        
        return Output(
            isLoading: isLoading.asDriver(),
            registerSuccessAlertAction: registerSuccessAlertAction.asDriver(onErrorJustReturn: ""),
            toastMessageAction: toastMessageAction.asDriver(onErrorJustReturn: "")
        )
    }
}

extension RegisterViewModel {
    
    func requestRegister(username: String, email: String, password: String) -> Single<RegisterInfo.Response> {
        let parameters = [ "username": username, "email": email, "password": password]
        let result = provider.rx.request(.register(parameters: parameters))
            .catchSessacError(SessacError.self)
            .map(RegisterInfo.Response.self)
        return result
    }
}
