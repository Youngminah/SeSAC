//
//  HomeViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let tableView = UITableView()
    private let composePostButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
    }
    
    private func setView() {
        view.addSubview(tableView)
        view.addSubview(composePostButton)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        composePostButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.right.equalTo(-30)
            make.bottom.equalTo(-60)
        }
    }
    
    private func setConfiguration() {
        view.backgroundColor = .systemBackground
        title = "새싹농장"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        
        tableView.backgroundColor = .systemGray6
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.rowHeight = 100
        tableView.sectionHeaderHeight = 15
        
        composePostButton.setImage(UIImage(systemName: "plus"), for: .normal)
        composePostButton.setPreferredSymbolConfiguration(.init(pointSize: 25,
                                                                weight: .semibold,
                                                                scale: .default),
                                                          forImageIn: .normal)
        composePostButton.tintColor = .white
        composePostButton.layer.masksToBounds = true
        composePostButton.layer.cornerRadius = 25
        composePostButton.backgroundColor = .systemGreen
        composePostButton.addTarget(self, action: #selector(composePostButtonTap), for: .touchUpInside)
    }
    
    @objc
    private func composePostButtonTap() {
        let vc = ComposeViewController()
        vc.title = "새싹농장 글쓰기"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
