//
//  LoginViewModel.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

typealias LoginRequestInfo = (email: String, password: String)

final class LoginViewModel: CommonViewModel, ViewModelType {
    
    struct Input {
        let loginRequestAPI: Signal<LoginRequestInfo>
    }
    struct Output {
        let isLoading: Driver<Bool>
        let loginSuccessAlertAction: Driver<String>
        let loginFailAlertAction: Driver<String>
        let toastMessageAction: Driver<String>
    }
    var disposeBag = DisposeBag()
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let loginSuccessAlertAction = PublishRelay<String>()
    private let loginFailAlertAction = PublishRelay<String>()
    private let toastMessageAction = PublishRelay<String>()
    
    override init() {
        super.init()
    }
    
    func transform(input: Input) -> Output {
        
        input.loginRequestAPI
            .do { [unowned self] _ in
                self.isLoading.accept(false)
            }
            .emit { [unowned self] info in
                self.requestLogin(info: info) { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success(let success):
                        self.setUserInfo(response: success)
                        self.isLoading.accept(true)
                        self.loginSuccessAlertAction.accept("로그인 되었습니다.")
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorCase
                        self.loginFailAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            isLoading: isLoading.asDriver(),
            loginSuccessAlertAction: loginSuccessAlertAction.asDriver(onErrorJustReturn: ""),
            loginFailAlertAction: loginFailAlertAction.asDriver(onErrorJustReturn: ""),
            toastMessageAction: toastMessageAction.asDriver(onErrorJustReturn: "")
        )
    }
    
    private func setUserInfo(response: RegisterInfo.Response) {
        TokenUtils.create(AppConfiguration.service, account: "accessToken", value: response.jwt)
        UserDefaults.standard.setValue(response.user.id, forKey: "id")
    }
}

extension LoginViewModel {
    
    private func requestLogin( info: LoginRequestInfo,
        completion: @escaping (Result<RegisterInfo.Response, Error>) -> Void
    ) {
        let parameters = ["identifier": info.email, "password": info.password]
        provider.request(.login(parameters: parameters)) { result in
            self.process(type: RegisterInfo.Response.self, result: result, completion: completion)
        }
    }
}
