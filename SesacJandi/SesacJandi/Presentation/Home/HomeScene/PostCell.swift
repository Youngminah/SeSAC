//
//  PostCell.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import SnapKit

final class PostCell: BaseTableViewCell {
    
    static let identifier = "PostCell"
    
    private let textView = ContentTextView()
    private let dateLabel = DateLabel()
    private let separatorLineView = SeparatorLineView()
    private let commentInfoView = CommentInfoView()
    
    let commentButton = UIButton()
    
    override func setView() {
        super.setView()
        contentView.addSubview(commentInfoView)
        contentView.addSubview(separatorLineView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(textView)
        contentView.addSubview(commentButton)
    }

    override func setConstraints() {
        super.setConstraints()
        commentInfoView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        separatorLineView.snp.makeConstraints { make in
            make.bottom.equalTo(commentInfoView.snp.top).offset(-16)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separatorLineView.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        textView.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.top).priority(999)
            make.leading.top.trailing.equalToSuperview()
        }
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(separatorLineView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    override func setConfiguration() {
        super.setConfiguration()
        dateLabel.text = "12월 8일"
        dateLabel.textAlignment = .right
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        selectionStyle = .none
    }
    
    func updateUI(contentText: String) {
        textView.text = contentText
        textView.sizeToFit()
    }
}
