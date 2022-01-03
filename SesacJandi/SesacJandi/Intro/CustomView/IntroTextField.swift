//
//  IntroTextField.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit.UITextField

final class IntroTextField: UITextField {
    
    override init(frame: CGRect) { // 코드로 뷰가 생성될 때 생성자
        super.init(frame: frame)
        self.setConfiguration()
    }
    
    convenience init(placeHolder text: String) {
        self.init()
        placeholder = text
    }
    
    required init?(coder: NSCoder) { //스토리보드로 뷰가 생성될 때 생성자
        fatalError()
    }
    
    private func setConfiguration(){
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray5.cgColor
        font = .systemFont(ofSize: 13)
        addPadding()
    }
    
    private func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }
}
