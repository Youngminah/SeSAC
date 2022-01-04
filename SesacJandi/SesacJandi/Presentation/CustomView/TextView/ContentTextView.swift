//
//  PostContentTextView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit.UITextView

class ContentTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setConfiguration()
    }
    
    required init?(coder: NSCoder) { //스토리보드로 뷰가 생성될 때 생성자
        fatalError()
    }
    
    func setConfiguration() {
        font = .systemFont(ofSize: 15)
        textContainer.lineFragmentPadding = CGFloat(0.0) //기본 패딩 제거
        textAlignment = .justified
        textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16);
    }
}
