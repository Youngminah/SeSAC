//
//  HomeViewModel.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

typealias RegisterRequestInfo = (username: String, email: String, password: String)

final class HomeViewModel: CommonViewModel {
    
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
    
    override init() {
        super.init()
    }
    
    func transform(input: Input) -> Output {
        
        input.registerButtonTapEvent
            .emit { [unowned self]  in
                self.requestAllPosts() { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success(let success):
                        self.isLoading.accept(true)
                        self.registerSuccessAlertAction.accept("회원가입이 정상적으로 완료되었습니다.")
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacError
                        self.registerFailAlertAction.accept(error.errorDescription)
                    }
                }
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

extension HomeViewModel {
    
    func requestAllPosts(completion: @escaping (Result<RegisterInfo.Response, Error>) -> Void ) {
        provider.request(.allPost) { result in
            self.process(type: RegisterInfo.Response.self, result: result, completion: completion)
        }
    }
}
