//
//  AnniversaryCell.swift
//  AnniversaryCalculator
//
//  Created by meng on 2021/10/07.
//

import UIKit

class AnniversaryCell: UICollectionViewCell {
    
    private let anniversaryView = UIAnniversaryView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(anniversaryView)
        anniversaryView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(at index: Int, at origin :Date){
        switch index {
        case 0 :
            let calculateDate = calculateAnniversaryDate(100, at: origin)
            anniversaryView.setTitle(date: "D+100", calculateDate: calculateDate, imageTitle: "마카롱1")
        case 1 :
            let calculateDate = calculateAnniversaryDate(200, at: origin)
            anniversaryView.setTitle(date: "D+200", calculateDate: calculateDate, imageTitle: "마카롱2")
        case 2 :
            let calculateDate = calculateAnniversaryDate(300, at: origin)
            anniversaryView.setTitle(date: "D+300", calculateDate: calculateDate, imageTitle: "마카롱3")
        default:
            let calculateDate = calculateAnniversaryDate(400, at: origin)
            anniversaryView.setTitle(date: "D+400", calculateDate: calculateDate, imageTitle: "마카롱4")
        }
    }
    
    private func calculateAnniversaryDate(_ dday: Int, at origin :Date) -> String{  // 기념일 계산해서 String으로 리턴
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년\nMM월 dd일"
        let calendar = Calendar.current
        let day = DateComponents(day: dday)
        guard let date = calendar.date(byAdding: day, to: origin) else {
            return "오류"
        }
        return formatter.string(from: date)
    }
}
