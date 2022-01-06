//
//  CommentViewController.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import UIKit
import RxCocoa
import RxSwift

final class PostViewController: UIViewController {
    
    private let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    private let commentInputView = CommentInputView()
    private lazy var detailMenuBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(detailMenuBarButtonTap))
    
    private lazy var input = PostViewModel.Input(
        requestAllCommentsEvent: requestAllCommentsEvent.asSignal(),
        requestCreateCommentEvent: requestCreateCommentEvent.asSignal(),
        requestDeletePostEvent: requestDeletePostEvent.asSignal(),
        requestDeleteCommentEvent: requestDeleteCommentEvent.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    private let viewModel : PostViewModel
    private let requestAllCommentsEvent = PublishRelay<Void>()
    private let requestCreateCommentEvent = PublishRelay<String>()
    private let requestDeletePostEvent = PublishRelay<Void>()
    private let requestDeleteCommentEvent = PublishRelay<Int>()
    private let disposeBag = DisposeBag()
    
    var basicInfo: PostResponse
    var commentCount: Int
    
    init(basicInfo: PostResponse) {
        self.basicInfo = basicInfo
        self.commentCount = basicInfo.comments.count
        self.viewModel = PostViewModel(postID: basicInfo.id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        setConfiguration()
        bindUI()
        bind()
        requestAllCommentsEvent.accept(())
    }
    
    private func bind() {
        output.didLoadallComments
            .drive(tableView.rx.items) { [weak self] (tableView, row, comment) in
                guard let self = self else { return UITableViewCell() }
                let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier) as! CommentCell
                cell.updateUI(comment: comment)
                cell.buttonTappedAction = { _ in
                    self.showPostActionSheet(
                        deleteHandler: { _ in
                            self.requestDeleteCommentEvent.accept(comment.id)
                        },
                        editHandler: { _ in
                            self.showEditCommentViewController(cell: cell, comment: comment)
                        })
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        output.successAlertAction
            .emit(onNext: { [unowned self] action in
                switch action {
                case .postDelete:
                    self.showPostDeleteAlert(title: action.rawValue)
                case .postEdit:
                    print("수정이벤트 방출")
                case .commentCreate, .commentDelete:
                    self.showCommentAlert(title: action.rawValue)
                    self.commentInputView.setPlaceHolder()
                }
            })
            .disposed(by: disposeBag)
        
        output.failAlertAction
            .emit(onNext: { [unowned self] title in
                let alert = self.confirmAlert(title: title)
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.commentsCount
            .emit(onNext: { [unowned self] count in
                self.commentCount = count
            })
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        commentInputView.commentTextView.rx.didBeginEditing
            .asSignal()
            .emit(onNext: { [unowned self] _ in
                self.commentInputView.removePlaceHolder()
            })
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
        
        tableView.register(CommentCell.self,
                           forCellReuseIdentifier: CommentCell.identifier)
        tableView.separatorInset.right = 16
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 200
        tableView.register(PostHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: PostHeaderView.identifier)
        tableView.separatorInset.right = 16

        commentInputView.commentPostButton.addTarget(self,
                                                     action: #selector(createCommentButtonTap),
                                                     for: .touchUpInside)
        
        if !isValidateMenuButton(userID: basicInfo.user.id) {
            navigationItem.rightBarButtonItems = []
        }
    }
    
    @objc
    private func detailMenuBarButtonTap() {
        self.showPostActionSheet(
            deleteHandler: { [weak self] _ in
                self?.requestDeletePostEvent.accept(())
            },
            editHandler: { [weak self] _ in
                self?.showEditPostViewController()
            })
    }
    
    @objc
    private func createCommentButtonTap() {
        self.requestCreateCommentEvent.accept(commentInputView.commentTextView.text!)
    }
    
    private func isValidateMenuButton(userID: Int) -> Bool {
        let myID = UserDefaults.standard.integer(forKey: "id")
        return myID == userID
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostHeaderView.identifier) as! PostHeaderView
        headerView.updateUI(info : basicInfo)
        headerView.commentInfoView.setCommentCount(count: commentCount)
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

extension PostViewController {
    
    private func showCommentAlert(title: String) {
        let alert = self.confirmAlert(title: title, okHandler: { _ in
            self.requestAllCommentsEvent.accept(())
        })
        self.present(alert, animated: true)
    }
    
    private func showPostDeleteAlert(title: String) {
        let alert = self.confirmAlert(title: title, okHandler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    private func showPostActionSheet(
        deleteHandler:
        @escaping AlertActionHandler,
        editHandler: @escaping AlertActionHandler
    ) {
        let optionMenu  = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive, handler: deleteHandler)
        let editAction = UIAlertAction(title: "수정하기", style: .default, handler: editHandler)
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true)
    }
    
    private func showEditPostViewController() {
        let vc = ComposePostViewController(mode: .edit, postInfo: basicInfo)
        vc.closure = { [unowned self] text in
            self.basicInfo.text = text
            self.tableView.reloadData()
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    private func showEditCommentViewController(cell: CommentCell, comment: CommentResponse) {
        let vc = EditCommentViewController(comment: comment)
        vc.title = "댓글 수정하기"
        vc.closure = { comment in
            cell.commentContentView.text = comment
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
