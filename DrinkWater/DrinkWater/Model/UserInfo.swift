//
//  UserInfo.swift
//  DrinkingWater
//
//  Created by meng on 2021/10/10.
//

import UIKit


struct UserInfo: Codable {
    var nickName: String
    var height: Int
    var weight: Int
    var accumulateWater: Int = 0
    var recommendIntake: Float { return Float(height + weight)/100.0 }
    var percentGoal: Int { return Int(Float(accumulateWater) / (recommendIntake * 1000.0) * 100.0) }
}
