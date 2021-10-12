//
//  UserViewModel.swift
//  DrinkingWater
//
//  Created by meng on 2021/10/10.
//
import UIKit

final class UserViewModel {
    private var userInfo: UserInfo?
    
    init() {
        if let data = UserDefaults.standard.value(forKey:"userInfo") as? Data {
            let userInfo = try? PropertyListDecoder().decode(UserInfo.self, from: data)
            self.userInfo = userInfo
        }
    }
    
    var nickName: String { return userInfo!.nickName }
    var height: Int { return userInfo!.height }
    var weight: Int { return userInfo!.weight }
    var accumulateWater: Int { return userInfo?.accumulateWater ?? 0 }
    var recommendIntake: Float { return userInfo?.recommendIntake ?? 0 }
    var percentGoal: Int { return userInfo?.percentGoal ?? 0 }
    
    var recommendIntakeText: String {
        if isNoUser() { return "프로필을 등록하면 권창 섭취량을 알려드려요 😆" }
        else { return nickName + "님의 하루 물 권장 섭취량을 \(recommendIntake)L입니다." }
    }
    
    var percentGoalText: String {
        return "목표의 \(percentGoal)%"
    }
    
    var intakeText: String {
        return "\(accumulateWater)ml"
    }
    
    var phraseText: String {
        if percentGoal == 0  {
            return "시작해볼까요?\n오늘 마신 양은"
        } else if percentGoal >= 100 {
            return "축하해요🎉 하루 권장량을 채웠어요!\n오늘 마신 양은"
        } else {
            return "잘하셨어요!\n오늘 마신 양은"
        }
    }
    
    var phraseColor: UIColor {
        return percentGoal >= 100 ? .systemIndigo : .white
    }
    
    func initialUserInfo(nickName: String, height: Int, weight: Int) {
        userInfo = UserInfo(nickName: nickName, height: height, weight: weight)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userInfo), forKey:"userInfo")
    }
    
    func updateUserInfo(nickName: String, height: Int, weight: Int) {
        userInfo = UserInfo(nickName: nickName, height: height, weight: weight, accumulateWater: accumulateWater)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userInfo), forKey:"userInfo")
    }
    
    func updateAccumulateWater(ml accumulateWater: Int) {
        userInfo = UserInfo(nickName: nickName, height: height, weight: weight, accumulateWater: accumulateWater)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userInfo), forKey:"userInfo")
    }
    
    func isNoUser() -> Bool {
        guard let _ = userInfo else { return true }
        return false
    }
}
