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
    
    private lazy var input = PostViewModel.Input(
        viewDidLoadEvent: viewDidLoadEvent.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    private let viewModel = PostViewModel()
    private let viewDidLoadEvent = PublishRelay<Int>()
    private let disposeBag = DisposeBag()
    
    var basicInfo: PostResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
        bind()
        viewDidLoadEvent.accept(basicInfo!.id)
    }
    
    private func bind() {
        output.didLoadallComments
            .drive(tableView.rx.items) { (tableView, row, comment) in
                let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier) as! CommentCell
                cell.updateUI(comment: comment)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
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
        tableView.separatorInset.right = 16

        if !isValidateMenuButton(userID: basicInfo!.user.id) {
            navigationItem.rightBarButtonItems = []
        }
    }
    
    @objc
    private func detailMenuBarButtonTap() {
    
    }
    
    private func isValidateMenuButton(userID: Int) -> Bool {
        let myID = UserDefaults.standard.integer(forKey: "id")
        return myID == userID
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostHeaderView.identifier) as! PostHeaderView
        if let info = basicInfo {
            headerView.updateUI(info : info)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
