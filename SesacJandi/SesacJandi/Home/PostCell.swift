//
//  PostCell.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import SnapKit

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    
    private let textView = UITextView()
    private let dateLabel = UILabel()
    private let separatorLineView = SeparatorLineView()
    private let commentInfoView = CommentInfoView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
        setConstraints()
        setConfiguration()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setView() {
        addSubview(textView)
        addSubview(dateLabel)
        addSubview(separatorLineView)
        addSubview(commentInfoView)
    }

    private func setConstraints() {
        commentInfoView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        separatorLineView.snp.makeConstraints { make in
            make.bottom.equalTo(commentInfoView.snp.top).offset(16)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separatorLineView.snp.top).offset(16)
            
        }
        textView.snp.makeConstraints { make in
            
        }
    }
    
    private func setConfiguration() {

    }
}
