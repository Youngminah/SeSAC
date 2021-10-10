//
//  UIImage.swift
//  DrinkingWater
//
//  Created by meng on 2021/10/10.
//
import UIKit

extension UIImageView {
    func setPlantImage(at percentWater: Int) {
        if 0 <= percentWater && percentWater < 10 {
            image = UIImage(named: "1-1")
        } else if 10 <= percentWater && percentWater < 20 {
            image = UIImage(named: "1-2")
        } else if 20 <= percentWater && percentWater < 30 {
            image = UIImage(named: "1-3")
        } else if 30 <= percentWater && percentWater < 40 {
            image = UIImage(named: "1-4")
        } else if 40 <= percentWater && percentWater < 50 {
            image = UIImage(named: "1-5")
        } else if 50 <= percentWater && percentWater < 60 {
            image = UIImage(named: "1-6")
        } else if 60 <= percentWater && percentWater < 75 {
            image = UIImage(named: "1-7")
        } else if 75 <= percentWater && percentWater < 90 {
            image = UIImage(named: "1-8")
        } else {
            image = UIImage(named: "1-9")
        }
    }
}
