//
//  ComposeViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa

class ComposePostViewController: UIViewController {
    
    private let contentTextView = ContentTextView()
    
    private lazy var dismissBarButton = UIBarButtonItem(barButtonSystemItem: .close,
                                                   target: self,
                                                   action: #selector(dismissBarButtonTap))
    private lazy var completedBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                                     target: self,
                                                     action: #selector(completedBarButtonTap))
    private lazy var input = ComposePostViewModel.Input(
        saveButtonTapEvent: saveButtonTapEvent.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    private let viewModel = ComposePostViewModel()
    private let saveButtonTapEvent = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
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
                    self.dismiss(animated: true)
                })
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.composeFailAlertAction
            .emit(onNext: { [unowned self] title in
                let alert = self.confirmAlert(title: title)
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
        view.backgroundColor = .systemBackground
        contentTextView.becomeFirstResponder()
    }
    
    @objc
    private func dismissBarButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func completedBarButtonTap() {
        saveButtonTapEvent.accept(self.contentTextView.text!)
    }
}
