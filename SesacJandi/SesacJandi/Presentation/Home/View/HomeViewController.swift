//
//  HomeViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private var tableView = UITableView()
    private let composePostButton = UIButton()
    private lazy var logoutBarButton = UIBarButtonItem(title: "로그아웃",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(logoutBarButtonTap))
    private lazy var changePasswordBarButton = UIBarButtonItem(title: "비번변경",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(changePasswordBarButtonTap))
    
    private lazy var input = HomeViewModel.Input(
        requestAllPostsEvent: requestAllPostsEvent.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    private let viewModel = HomeViewModel()
    private let requestAllPostsEvent = PublishRelay<Void>()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
        bind()
        requestAllPostsEvent.accept(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestAllPostsEvent.accept(())
    }
    
    private func bind() {
        output.didLoadallPosts
            .drive(tableView.rx.items) { (tableView, row, post) in
                let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as! PostCell
                cell.updateUI(post: post)
                return cell
            }
            .disposed(by: disposeBag)
        
        Observable.zip( tableView.rx.itemSelected,
                        tableView.rx.modelSelected(PostResponse.self))
            .subscribe(onNext: { [unowned self] indexPath, data in
                let vc = PostViewController(basicInfo: data)
                self.navigationController?.pushViewController(vc, animated: true)
             })
             .disposed(by: disposeBag)
        
        output.loadFailAlertAction
            .emit(onNext: { [unowned self] title in
                let alert = self.confirmAlert(title: title) { [weak self] _ in
                    if title == "로그아웃 합니다." {
                        self?.changeIntroViewController()
                    }
                }
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setView() {
        navigationItem.rightBarButtonItem = logoutBarButton
        navigationItem.leftBarButtonItem = changePasswordBarButton
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
    private func logoutBarButtonTap() {
        TokenUtils.delete(AppConfiguration.service, account: "accessToken")
        self.changeIntroViewController()
    }
    
    @objc
    private func changePasswordBarButtonTap() {
        let vc = PasswordChangeViewController()
        vc.title = "비번변경"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func composePostButtonTap() {
        let vc = ComposePostViewController(mode: .create, postInfo: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
