//
//  RegisterViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Toast

final class RegisterViewController: UIViewController {

    private let emailTextField = IntroTextField(placeHolder: "이메일 주소")
    private let nickNameTextField = IntroTextField(placeHolder: "닉네임")
    private let passwordTextField = IntroTextField(placeHolder: "비밀번호")
    private let passwordConfirmTextField = IntroTextField(placeHolder: "비밀번호 확인")
    private let registerButton = IntroButton(title: "가입하기")
    
    private let viewModel = RegisterViewModel()
    private lazy var stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                                nickNameTextField,
                                                                passwordTextField,
                                                                passwordConfirmTextField])
    
    private lazy var input = RegisterViewModel.Input(
        registerButtonTapEvent: registerButtonTapEvent.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    private var registerButtonTapEvent = PublishRelay<RegisterRequestInfo>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
        bind()
    }
    
    private func bind() {
//        output.isLoading
//            .drive(registerButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        output.registerSuccessAlertAction
            .drive(onNext: { [unowned self] title in
                let alert = self.confirmAlert(title: title, okHandler: { _ in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.registerFailAlertAction
            .drive(onNext: { [unowned self] title in
                let alert = self.confirmAlert(title: title)
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.toastMessageAction
            .drive(onNext: { [unowned self] message in
                self.makeToastStyle()
                self.view.makeToast(message, position: .top)
            })
            .disposed(by: disposeBag)
    }
    
    private func setView() {
        view.addSubview(stackView)
        view.addSubview(registerButton)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(230)
        }
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }
    
    private func setConfiguration() {
        view.backgroundColor = .systemBackground
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        registerButton.isEnabled = true
        registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func registerButtonTap() {
        registerButtonTapEvent.accept((username: "hello",
                                       email: "email12@gmail.com",
                                       password: "email"))
    }
}
