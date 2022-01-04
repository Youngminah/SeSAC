//
//  CommentContentTextView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import UIKit.UITextView

final class CommentInputTextView: ContentTextView {
    
    override func setConfiguration() {
        super.setConfiguration()
        textContainerInset = UIEdgeInsets(top: 16, left: 10, bottom: 10, right: 16);
        backgroundColor = .systemGray5
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}
