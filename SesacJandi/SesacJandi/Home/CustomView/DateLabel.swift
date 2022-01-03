//
//  DateLabel.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit.UILabel

final class DateLabel: UILabel {
    
    override init(frame: CGRect) { // 코드로 뷰가 생성될 때 생성자
        super.init(frame: frame)
        self.setConfiguration()
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    required init?(coder: NSCoder) { //스토리보드로 뷰가 생성될 때 생성자
        fatalError()
    }
    
    private func setConfiguration(){
        font = .systemFont(ofSize: 13)
    }
}
