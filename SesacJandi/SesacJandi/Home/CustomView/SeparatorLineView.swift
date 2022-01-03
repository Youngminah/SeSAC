//
//  SeparatorLineView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/03.
//

import UIKit.UIView

final class SeparatorLineView: UIView {
    
    override init(frame: CGRect) { // 코드로 뷰가 생성될 때 생성자
        super.init(frame: frame)
        setConfiguration()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfiguration(){
        backgroundColor = .systemGray6
    }
}
