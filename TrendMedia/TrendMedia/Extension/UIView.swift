//
//  UIView.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//
import UIKit

extension UIView{
    func setCornerShadow() {
        layer.cornerRadius = 10
        //layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5.0
        backgroundColor = .white
    }
}
