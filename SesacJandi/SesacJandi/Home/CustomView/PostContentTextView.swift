//
//  PostContentTextView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit.UITextView

final class PostContentTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setConfiguration()
    }
    
    required init?(coder: NSCoder) { //스토리보드로 뷰가 생성될 때 생성자
        fatalError()
    }
    
    private func setConfiguration(){
        font = .systemFont(ofSize: 13)
        textContainer.lineFragmentPadding = CGFloat(0.0) //기본 패딩 제거
        textAlignment = .justified
    }
}
