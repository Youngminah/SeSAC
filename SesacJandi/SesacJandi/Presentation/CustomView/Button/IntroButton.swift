//
//  IntroButton.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit.UIButton

final class IntroButton: UIButton {
    
    override var isEnabled : Bool {
        didSet { backgroundColor = isEnabled ? .systemGreen : .lightGray }
    }
    
    override init(frame: CGRect) { // 코드로 뷰가 생성될 때 생성자
        super.init(frame: frame)
        self.setConfiguration()
    }
    
    convenience init(title text: String) {
        self.init()
        setTitle(text, for: .normal)
    }
    
    required init?(coder: NSCoder) { //스토리보드로 뷰가 생성될 때 생성자
        fatalError()
    }
    
    private func setConfiguration(){
        layer.masksToBounds = true
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        backgroundColor = .systemGreen
    }
}
