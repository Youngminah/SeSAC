//
//  TagButton.swift
//  newlyCoinedWord
//
//  Created by meng on 2021/10/06.
//

import UIKit

class UITagButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) { //NSCoding 때문.
        super.init(coder: coder)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        self.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        self.sizeToFit()
    }
    
    private func setup(){
        self.setTitleColor(.black, for: .normal)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.titleLabel?.font = .systemFont(ofSize: 11, weight: .regular)
        self.backgroundColor = .white
    }
}
