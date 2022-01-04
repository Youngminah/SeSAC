//
//  CommentInputView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit
import SnapKit

final class CommentInputView: UIView {
    
    private let separatorLineView = SeparatorLineView()
    private let commentTextView = CommentInputTextView()
    let commentPostButton = UIButton()
    
    override init(frame: CGRect) { // 코드로 뷰가 생성될 때 생성자
        super.init(frame: frame)
        setView()
        setContraints()
        setConfiguration()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        addSubview(separatorLineView)
        addSubview(commentTextView)
        addSubview(commentPostButton)
    }
    
    private func setContraints(){
        separatorLineView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(1)
        }
        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(separatorLineView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.bottom.equalToSuperview().offset(-30)
        }
        commentPostButton.snp.makeConstraints { make in
            make.left.equalTo(commentTextView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(separatorLineView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    private func setConfiguration(){
        commentTextView.backgroundColor = .systemGray5
        setPlaceHolder()
        
        commentPostButton.layer.masksToBounds = true
        commentPostButton.layer.cornerRadius = 20
        commentPostButton.backgroundColor = .label
        commentPostButton.setTitle("등록", for: .normal)
        commentPostButton.setTitleColor(.systemBackground, for: .normal)
        commentPostButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    private func setPlaceHolder() {
        commentTextView.text = "댓글을 입력해주세요"
        commentTextView.textColor = .gray
    }
    
    private func removePlaceHolder() {
        commentTextView.text = ""
        commentTextView.textColor = .label
    }
}
