//
//  ProfileImageView.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import UIKit.UIImageView

final class ProfileImageView: UIImageView {
    
    override init(image: UIImage? = nil) {
        super.init(image: image)
        self.setConfiguration()
    }
    
    required init?(coder: NSCoder) { 
        fatalError()
    }
    
    private func setConfiguration(){
        image = UIImage(systemName: "person.circle.fill")
        contentMode = .scaleAspectFill
        tintColor = .lightGray
    }
}
