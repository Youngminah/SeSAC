//
//  HomeViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private var tableView = UITableView()
    private let composePostButton = UIButton()
    let disposeBag = DisposeBag()
    
    let data = Observable.just([
        "안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕",
        "안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕",
        "안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕"
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
        bind()
    }
    
    private func bind() {
        data
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as! PostCell
                cell.updateUI(contentText: element)
                cell.commentButton.addTarget(self,
                                             action: #selector(self.commentButtonTap),
                                             for: .touchUpInside)
                return cell
            }
            .disposed(by: disposeBag)
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
        
        tableView.backgroundColor = .systemGray6
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorInset.left = 0
        
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
    
    @objc
    private func commentButtonTap() {
        let vc = PostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
