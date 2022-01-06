//
//  CommentCell.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import UIKit

final class CommentCell: BaseTableViewCell {
    
    static let identifier = "CommentCell"
    
    private let nickNameLabel = NickNameLabel()
    let commentContentView = ContentTextView()
    
    var buttonTappedAction : ((UITableViewCell) -> Void)?
    let commentDetailMenuButton = UIButton()
    
    let name = "안녕"
    
    override func setView() {
        addSubview(nickNameLabel)
        addSubview(commentContentView)
        addSubview(commentDetailMenuButton)
    }

    override func setConstraints() {
        commentDetailMenuButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(30)
            make.top.equalToSuperview().offset(16)
        }
        nickNameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalTo(commentDetailMenuButton.snp.left).offset(-16)
            make.height.equalTo(30)
        }
        commentContentView.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().priority(999)
        }
    }
    
    override func setConfiguration() {
        super.setConfiguration()
        commentDetailMenuButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        commentDetailMenuButton.tintColor = .label
        commentContentView.isScrollEnabled = false
        commentContentView.isEditable = false
        
        commentDetailMenuButton.addTarget(self,
                                          action: #selector(self.commmentDetailButtonTap),
                                          for: .touchUpInside)
    }
    
    func updateUI(comment: CommentResponse) {
        commentDetailMenuButton.isHidden = !isValidateMenuButton(userID: comment.user.id)
        nickNameLabel.text = comment.user.username
        commentContentView.text = comment.comment
        commentContentView.sizeToFit()
    }
    
    @objc
    private func commmentDetailButtonTap() {
        buttonTappedAction?(self)
    }
    
    private func isValidateMenuButton(userID: Int) -> Bool {
        let myID = UserDefaults.standard.integer(forKey: "id")
        return myID == userID
    }
}
