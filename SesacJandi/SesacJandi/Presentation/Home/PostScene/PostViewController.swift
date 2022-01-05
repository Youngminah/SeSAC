//
//  CommentViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import UIKit
import RxSwift
import RxCocoa

final class PostViewController: UIViewController {
    
    private let tableView = UITableView()
    private let commentInputView = CommentInputView()
    private lazy var detailMenuBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(detailMenuBarButtonTap))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
        bind()
    }
    
    private func bind() {

    }
    
    private func setView() {
        navigationItem.rightBarButtonItem = detailMenuBarButton
        view.addSubview(commentInputView)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        commentInputView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(commentInputView.snp.top)
        }
    }
    
    private func setConfiguration() {
        view.backgroundColor = .systemBackground
        

        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        tableView.separatorInset.right = 16
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 200
        tableView.register(PostHeaderView.self, forHeaderFooterViewReuseIdentifier: PostHeaderView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.right = 16
    }
    
    @objc
    private func detailMenuBarButtonTap() {
    
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostHeaderView.identifier) as! PostHeaderView
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier) as! CommentCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
