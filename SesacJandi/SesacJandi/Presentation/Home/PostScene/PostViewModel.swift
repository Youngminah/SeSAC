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

enum PoetViewSuccessAction: String {
    case postDelete = "글이 삭제되었습니다."
    case postEdit = "글이 수정되었습니다."
    case commentCreate = "댓글이 작성되었습니다."
//    case commentEdit = "댓글이 수정되었습니다."
//    case commentDelete = "댓글이 삭제되었습니다."
}

final class PostViewModel: CommonViewModel {
    
    struct Input {
        let requestAllCommentsEvent: Signal<Void>
        let requestCreateCommentEvent: Signal<String>
        let requestDeletePostEvent: Signal<Void>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let toastMessageAction: Signal<String>
        let didLoadallComments: Driver<[CommentResponse]>
        let successAlertAction: Signal<PoetViewSuccessAction>
        let commentsCount: Signal<Int>
        let failAlertAction: Signal<String>
    }
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let toastMessageAction = PublishRelay<String>()
    private let didLoadallComments = BehaviorRelay<[CommentResponse]>(value: [])
    private let successAlertAction = PublishRelay<PoetViewSuccessAction>()
    private let commentsCount = PublishRelay<Int>()
    private let failAlertAction = PublishRelay<String>()
    
    private let disposeBag = DisposeBag()
    private var postID : Int
    
    init(postID: Int) {
        self.postID = postID
    }
    
    func transform(input: Input) -> Output {
        input.requestAllCommentsEvent
            .emit { [unowned self] _ in
                self.requestAllComments() { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success(let success):
                        self.isLoading.accept(true)
                        self.commentsCount.accept(success.count)
                        self.didLoadallComments.accept(success)
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorEnum
                        self.failAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.requestCreateCommentEvent
            .emit { [unowned self] text in
                self.requestCreateComment(text: text) { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success(_):
                        self.isLoading.accept(true)
                        self.successAlertAction.accept(.commentCreate)
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorEnum
                        self.failAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.requestDeletePostEvent
            .emit { [unowned self] text in
                self.requestDeletePost() { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success(_):
                        self.isLoading.accept(true)
                        self.successAlertAction.accept(.postDelete)
                    case .failure(let error):
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorEnum
                        self.failAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            isLoading: isLoading.asDriver(),
            toastMessageAction: toastMessageAction.asSignal(),
            didLoadallComments: didLoadallComments.asDriver(),
            successAlertAction: successAlertAction.asSignal(),
            commentsCount: commentsCount.asSignal(),
            failAlertAction: failAlertAction.asSignal()
        )
    }
}

extension PostViewModel {
    
    func requestAllComments(completion: @escaping (Result<[CommentResponse], Error>) -> Void ) {
        let parameters = ["post": "\(postID)"]
        provider.request(.allComment(parameters: parameters)) { result in
            self.process(type: [CommentResponse].self, result: result, completion: completion)
        }
    }
    
    func requestCreateComment(text: String,
                              completion: @escaping (Result<CommentResponse, Error>) -> Void ) {
        let parameters = ["comment": text, "post": "\(postID)"]
        provider.request(.createComment(parameters: parameters)) { result in
            self.process(type: CommentResponse.self, result: result, completion: completion)
        }
    }
    
    func requestDeletePost(completion: @escaping (Result<PostResponse, Error>) -> Void ) {
        provider.request(.deletePost(index: postID)) { result in
            self.process(type: PostResponse.self, result: result, completion: completion)
        }
    }
}
