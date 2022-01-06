//
//  EditCommentViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import UIKit
import RxCocoa
import RxSwift

class EditCommentViewController: UIViewController {
    
    private let contentTextView = ContentTextView()
    private lazy var completedBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                                     target: self,
                                                     action: #selector(completedBarButtonTap))
    
    private lazy var input = EditCommentViewModel.Input(
        requestEditCommentEvent: requestEditCommentEvent.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    private var viewModel: EditCommentViewModel
    private let disposeBag = DisposeBag()
    
    private let requestEditCommentEvent = PublishRelay<String>()
    private let comment: CommentResponse
    
    var closure: ((_ comment: String) -> ())?
    
    init(comment: CommentResponse) {
        self.comment = comment
        self.viewModel = EditCommentViewModel(comment: comment)
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
        output.successAlertAction
            .emit(onNext: { [weak self] title in
                guard let self = self else { return }
                let alert = self.confirmAlert(title: title, okHandler: { _ in
                    self.closure?(self.contentTextView.text!)
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.failAlertAction
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
        navigationItem.rightBarButtonItem = completedBarButton
        view.addSubview(contentTextView)
    }
    
    private func setConstraints() {
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(300)
        }
    }
    
    private func setConfiguration() {
        view.backgroundColor = .systemGray5
        contentTextView.becomeFirstResponder()
        contentTextView.layer.cornerRadius = 10
        contentTextView.text = comment.comment
    }
    
    @objc
    private func completedBarButtonTap() {
        requestEditCommentEvent.accept(contentTextView.text!)
    }
}
