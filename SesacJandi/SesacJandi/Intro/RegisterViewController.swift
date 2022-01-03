//
//  RegisterViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import SnapKit

final class RegisterViewController: UIViewController {

    private let emailTextField = IntroTextField(placeHolder: "이메일 주소")
    private let nickNameTextField = IntroTextField(placeHolder: "닉네임")
    private let passwordTextField = IntroTextField(placeHolder: "비밀번호")
    private let passwordConfirmTextField = IntroTextField(placeHolder: "비밀번호 확인")
    private let registerButton = IntroButton(title: "가입하기")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                                nickNameTextField,
                                                                passwordTextField,
                                                                passwordConfirmTextField])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
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
        
        registerButton.isEnabled = false
        registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
    }
    
    @objc func registerButtonTap() {
        
    }
}
