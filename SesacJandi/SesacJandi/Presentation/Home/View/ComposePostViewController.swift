//
//  ComposeViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import RxCocoa
import RxSwift

enum Mode: String {
    case create = "새싹농장 글쓰기"
    case edit = "새싹농장 글 수정하기"
}

class ComposePostViewController: UIViewController {
    
    private let contentTextView = ContentTextView()
    
    private lazy var dismissBarButton = UIBarButtonItem(barButtonSystemItem: .close,
                                                   target: self,
                                                   action: #selector(dismissBarButtonTap))
    private lazy var completedBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                                     target: self,
                                                     action: #selector(completedBarButtonTap))
    
    private lazy var input = ComposePostViewModel.Input(
        requestPostEvent: requestPostEvent.asSignal(),
        requestEditPostEvent: requestEditPostEvent.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    private var viewModel: ComposePostViewModel
    private let disposeBag = DisposeBag()
    
    private let requestPostEvent = PublishRelay<String>()
    private let requestEditPostEvent = PublishRelay<String>()
    
    private let mode: Mode
    private let postInfo: PostResponse?
    var closure: ((_ text: String) -> ())?
    
    init(mode: Mode, postInfo: PostResponse?) {
        self.mode = mode
        self.postInfo = postInfo
        self.viewModel = ComposePostViewModel(mode: mode, postInfo: postInfo)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
        bind() 
    }
    
    private func bind() {
        output.composeSuccessAlertAction
            .emit(onNext: { [unowned self] title in
                let alert = self.confirmAlert(title: title, okHandler: { _ in
                    self.closure?(self.contentTextView.text!)
                    self.dismiss(animated: true)
                })
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.composeFailAlertAction
            .emit(onNext: { [unowned self] title in
                let alert = self.confirmAlert(title: title) { [weak self] _ in
                    if title == "로그아웃 합니다." {
                        self?.changeIntroViewController()
                    }
                }
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.toastMessageAction
            .emit(onNext: { [unowned self] message in
                self.makeToastStyle()
                self.view.makeToast(message, position: .top)
            })
            .disposed(by: disposeBag)
    }
    
    private func setView() {
        navigationItem.leftBarButtonItem = dismissBarButton
        navigationItem.rightBarButtonItem = completedBarButton
        view.addSubview(contentTextView)
    }
    
    private func setConstraints() {
        contentTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setConfiguration() {
        title = mode.rawValue
        view.backgroundColor = .systemBackground
        contentTextView.becomeFirstResponder()
        if mode == .edit {
            contentTextView.text = postInfo!.text
        }
    }
    
    @objc
    private func dismissBarButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func completedBarButtonTap() {
        switch mode {
        case .create:
            requestPostEvent.accept(self.contentTextView.text!)
        case .edit:
            requestEditPostEvent.accept(self.contentTextView.text!)
        }
    }
}
