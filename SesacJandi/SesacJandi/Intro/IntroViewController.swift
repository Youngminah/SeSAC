//
//  ViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import SnapKit

final class IntroViewController: UIViewController {
    
    private let logoImageView = UIImageView(image: UIImage(named: "logo_ssac_clear"))
    private let introTitleLabel = UILabel()
    private let introContentLabel = UILabel()
    private let startButton = IntroButton(title: "시작하기")
    private let loginLabel = UILabel()
    private let loginButton = UIButton()
    private lazy var stackView = UIStackView(arrangedSubviews: [loginLabel, loginButton])

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
    }
    
    private func setView() {
        view.addSubview(logoImageView)
        view.addSubview(introTitleLabel)
        view.addSubview(introContentLabel)
        view.addSubview(startButton)
        view.addSubview(stackView)
    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        introTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        introContentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    private func setConfiguration() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .systemBackground
        
        introTitleLabel.text = "당신 근처의 새싹농장"
        introTitleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        introContentLabel.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해보세요!"
        introContentLabel.numberOfLines = 0
        introContentLabel.font = .systemFont(ofSize: 13)
        
        loginLabel.text = "이미 계정이 있나요?"
        loginLabel.font = .systemFont(ofSize: 13)
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.systemGreen, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        
        startButton.addTarget(self, action: #selector(startButtonTap), for: .touchUpInside)
        
        [introTitleLabel, introContentLabel, loginLabel].forEach { label in
            label.textAlignment = .center
        }
    }
    
    @objc
    private func startButtonTap() {
        let vc = RegisterViewController()
        vc.title = "새싹농장 가입하기"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func loginButtonTap() {
        let vc = LoginViewController()
        vc.title = "새싹농장 로그인하기"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

