//
//  PostViewModel.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

final class ComposePostViewModel: CommonViewModel, ViewModelType {
    
    struct Input {
        let requestPostEvent: Signal<String>
        let requestEditPostEvent: Signal<String>
    }
    struct Output {
        let isLoading: Driver<Bool>
        let toastMessageAction: Signal<String>
        let composeSuccessAlertAction: Signal<String>
        let composeFailAlertAction: Signal<String>
    }
    var disposeBag = DisposeBag()
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let toastMessageAction = PublishRelay<String>()
    private let composeSuccessAlertAction = PublishRelay<String>()
    private let composeFailAlertAction = PublishRelay<String>()
    
    private let mode: Mode
    private let postInfo: PostResponse?
    
    init(mode: Mode, postInfo: PostResponse? = nil) {
        self.mode = mode
        self.postInfo = postInfo
    }
    
    func transform(input: Input) -> Output {
        input.requestPostEvent
            .emit { [unowned self] text in
                self.requestPost(text: text) { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success( _):
                        self.isLoading.accept(true)
                        self.composeSuccessAlertAction.accept("작성되었습니다")
                    case .failure(let error): 
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorCase
                        self.composeFailAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.requestEditPostEvent
            .emit { [unowned self] text in
                self.requestEditPost(text: text) { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success( _):
                        self.isLoading.accept(true)
                        self.composeSuccessAlertAction.accept("수정되었습니다")
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorCase
                        self.composeFailAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output (
            isLoading: isLoading.asDriver(),
            toastMessageAction: toastMessageAction.asSignal(),
            composeSuccessAlertAction: composeSuccessAlertAction.asSignal(),
            composeFailAlertAction: composeFailAlertAction.asSignal()
        )
    }
}

extension ComposePostViewModel {
    
    private func requestPost(text: String, completion: @escaping (Result<PostResponse, Error>) -> Void ) {
        let parameters = ["text": text]
        provider.request(.composePost(parameters: parameters)) { result in
            self.process(type: PostResponse.self, result: result, completion: completion)
        }
    }
    
    private func requestEditPost(text: String, completion: @escaping (Result<PostResponse, Error>) -> Void ) {
        let parameters = ["text": text]
        provider.request(.updatePost(index: postInfo!.id, parameters: parameters)) { result in
            self.process(type: PostResponse.self, result: result, completion: completion)
        }
    }
}
