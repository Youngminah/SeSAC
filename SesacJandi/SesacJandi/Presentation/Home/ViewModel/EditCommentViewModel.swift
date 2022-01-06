//
//  EditCommentViewModel.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

 
final class EditCommentViewModel: CommonViewModel, ViewModelType {
    
    struct Input {
        let requestEditCommentEvent: Signal<String>
    }
    struct Output {
        let isLoading: Driver<Bool>
        let toastMessageAction: Signal<String>
        let successAlertAction: Signal<String>
        let failAlertAction: Signal<String>
    }
    var disposeBag = DisposeBag()
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let toastMessageAction = PublishRelay<String>()
    private let successAlertAction = PublishRelay<String>()
    private let failAlertAction = PublishRelay<String>()
    
    private let commentInfo: CommentResponse
    
    init(comment: CommentResponse) {
        self.commentInfo = comment
    }
    
    func transform(input: Input) -> Output {
        
        input.requestEditCommentEvent
            .emit { [unowned self] comment in
                self.requestEditComment(comment: comment) { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success( _):
                        self.isLoading.accept(true)
                        self.successAlertAction.accept("댓글이 수정되었습니다.")
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorCase
                        self.failAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            isLoading: isLoading.asDriver(),
            toastMessageAction: toastMessageAction.asSignal(),
            successAlertAction: successAlertAction.asSignal(),
            failAlertAction: failAlertAction.asSignal()
        )
    }
}

extension EditCommentViewModel {
    
    func requestEditComment(comment: String, completion: @escaping (Result<CommentResponse, Error>) -> Void ) {
        let parameters = ["comment": comment, "post": "\(commentInfo.post.id)"]
        provider.request(.updateComment(index: commentInfo.id, parameters: parameters)) { result in
            self.process(type: CommentResponse.self, result: result, completion: completion)
        }
    }
}
