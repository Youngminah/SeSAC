//
//  HomeViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
    }
    
    private func setView() {
        view.addSubview(logoImageView)

    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
    }
    
    private func setConfiguration() {
        title = "새싹농장"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .systemBackground
    }
}
