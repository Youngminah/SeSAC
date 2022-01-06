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

final class PostViewModel: CommonViewModel {
    
    struct Input {
        let viewDidLoadEvent: Signal<Int>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let toastMessageAction: Signal<String>
        let didLoadallComments: Driver<[CommentResponse]>
        let loadFailAlertAction: Signal<String>
    }
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let toastMessageAction = PublishRelay<String>()
    private let didLoadallComments = BehaviorRelay<[CommentResponse]>(value: [])
    private let loadFailAlertAction = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    override init() {
        super.init()
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoadEvent
            .emit { [unowned self] postID in
                self.requestAllComments(postID: postID) { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success(let success):
                        self.isLoading.accept(true)
                        self.didLoadallComments.accept(success)
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorEnum
                        self.loadFailAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            isLoading: isLoading.asDriver(),
            toastMessageAction: toastMessageAction.asSignal(),
            didLoadallComments: didLoadallComments.asDriver(),
            loadFailAlertAction: loadFailAlertAction.asSignal()
        )
    }
}

extension PostViewModel {
    
    func requestAllComments(postID: Int, completion: @escaping (Result<[CommentResponse], Error>) -> Void ) {
        let parameters = ["post": "\(postID)"]
        provider.request(.allComment(parameters: parameters)) { result in
            self.process(type: [CommentResponse].self, result: result, completion: completion)
        }
    }
}
