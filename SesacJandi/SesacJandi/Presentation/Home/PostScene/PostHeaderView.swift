//
//  PostHeaderView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import UIKit
import SnapKit

final class PostHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "PostHeaderView"

    private let profileImageView = ProfileImageView()
    private let nickNameLabel = NickNameLabel()
    private let dateLabel = DateLabel()
    private let profileSeparatorLineView = SeparatorLineView()
    private let contentTextView = ContentTextView()
    private let commentSeparatorLineView = SeparatorLineView()
    private let commentInfoView = CommentInfoView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setView()
        setConstraints()
        setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubview(commentInfoView)
        addSubview(commentSeparatorLineView)
        addSubview(profileImageView)
        addSubview(nickNameLabel)
        addSubview(dateLabel)
        addSubview(profileSeparatorLineView)
        addSubview(contentTextView)
    }

    private func setConstraints() {
        commentInfoView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        commentSeparatorLineView.snp.makeConstraints { make in
            make.bottom.equalTo(commentInfoView.snp.top).offset(-16)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(60)
        }
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(profileImageView.snp.bottom)
        }
        profileSeparatorLineView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(profileSeparatorLineView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(commentSeparatorLineView.snp.top).priority(999)
        }
    }
    
    private func setConfiguration() {
        contentTextView.isScrollEnabled = false
        contentTextView.isEditable = false
        commentInfoView.setCommentCount(count: 0)
        
        //ui테스트
        nickNameLabel.text = "헬로우헬로우"
        dateLabel.text = "12월 8일"
        contentTextView.text = "낄낄낄룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루룰루"
        contentTextView.sizeToFit()
    }
}
