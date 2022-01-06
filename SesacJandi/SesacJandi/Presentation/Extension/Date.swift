//
//  Date.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

extension Date {
    
    var toString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateFormat = "yy년MM월dd일 h:mma"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }
    
    var toRelativeTodayTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

extension String {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        let date = dateFormatter.date(from: self)!
        return date
    }
    
    var toformattedDate: String {
        let components = self.components(separatedBy: ["T", ".", "-", ":"])
        let month = components[1]
        let day = components[2]
        let hr = String(format: "%02d", (Int(components[3])! + 9) % 24)
        let min = components[4]
        return "\(month)/\(day) \(hr):\(min)"
    }
    
}
