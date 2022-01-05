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
        let registerFailAlertAction: Driver<String>
        let toastMessageAction: Driver<String>
    }
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let registerSuccessAlertAction = PublishRelay<String>()
    private let registerFailAlertAction = PublishRelay<String>()
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
            .emit { [unowned self] info in
                self.registerErrorHandler(info: info)
            }
            .disposed(by: disposeBag)
        
        return Output(
            isLoading: isLoading.asDriver(),
            registerSuccessAlertAction: registerSuccessAlertAction.asDriver(onErrorJustReturn: ""),
            registerFailAlertAction: registerFailAlertAction.asDriver(onErrorJustReturn: ""),
            toastMessageAction: toastMessageAction.asDriver(onErrorJustReturn: "")
        )
    }
}

extension RegisterViewModel {
    
    private func registerErrorHandler(info: RegisterRequestInfo) {
        let parameters = [ "username": info.username, "email": info.email, "password": info.password]
        provider.rx.request(.register(parameters: parameters))
            .catchSessacError(SessacError.self)
            .map(RegisterInfo.Response.self)
            .subscribe ({ [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let success):
                    TokenUtils.create(AppConfiguration.service, account: "accessToken", value: success.jwt)
                    self.isLoading.accept(true)
                    self.registerSuccessAlertAction.accept("회원가입이 정상적으로 완료되었습니다.")
                case .failure(let error):
                    self.isLoading.accept(true)
                    let error = error as! SessacError
                    self.registerFailAlertAction.accept(error.errorDescription)
                }
            })
            .disposed(by: disposeBag)
    }
}
