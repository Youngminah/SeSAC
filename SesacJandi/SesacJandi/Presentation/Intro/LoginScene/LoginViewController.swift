//
//  LoginViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let emailTextField = IntroTextField(placeHolder: "이메일 주소")
    private let passwordTextField = IntroTextField(placeHolder: "비밀번호")
    private let loginButton = IntroButton(title: "로그인")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                                passwordTextField])

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
    }
    
    private func setView() {
        view.addSubview(stackView)
        view.addSubview(loginButton)
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(110)
        }
        loginButton.snp.makeConstraints { make in
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
        
        loginButton.isEnabled = true
        loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func loginButtonTap() {
        let vc = HomeViewController()
        let nav = HomeNavigationController(rootViewController: vc)
        changeRootViewController(nav)
    }
}
