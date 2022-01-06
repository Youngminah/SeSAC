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

final class HomeViewModel: CommonViewModel, ViewModelType {
    
    struct Input {
        let requestAllPostsEvent: Signal<Void>
    }
    struct Output {
        let isLoading: Driver<Bool>
        let toastMessageAction: Signal<String>
        let didLoadallPosts: Driver<[PostResponse]>
        let loadFailAlertAction: Signal<String>
    }
    var disposeBag = DisposeBag()
    
    private let isLoading = BehaviorRelay<Bool>(value: true)
    private let toastMessageAction = PublishRelay<String>()
    private let didLoadallPosts = BehaviorRelay<[PostResponse]>(value: [])
    private let loadFailAlertAction = PublishRelay<String>()
    
    override init() {
        super.init()
    }
    
    func transform(input: Input) -> Output {
        
        input.requestAllPostsEvent
            .emit { [unowned self] _ in
                self.requestAllPosts(pageIndex: 0) { [weak self] response in
                    guard let self = self else { return }
                    switch response {
                    case .success(let success):
                        self.isLoading.accept(true)
                        self.didLoadallPosts.accept(success)
                    case .failure(let error): 
                        self.isLoading.accept(true)
                        let error = error as! SessacErrorCase
                        self.loadFailAlertAction.accept(error.errorDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            isLoading: isLoading.asDriver(),
            toastMessageAction: toastMessageAction.asSignal(),
            didLoadallPosts: didLoadallPosts.asDriver(),
            loadFailAlertAction: loadFailAlertAction.asSignal()
        )
    }
}

extension HomeViewModel {
    
    func requestAllPosts(pageIndex: Int, completion: @escaping (Result<[PostResponse], Error>) -> Void ) {
        let parameters = ["_sort": "created_at:desc", "_start": "\(pageIndex)", "_limit": "20"]
        provider.request(.allPost(parameters: parameters)) { result in
            self.process(type: [PostResponse].self, result: result, completion: completion)
        }
    }
}
