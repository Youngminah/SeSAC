//
//  TheaterLocation.swift
//  TrendMedia
//
//  Created by meng on 2021/10/21.
//

struct TheaterLocation {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
}

enum Theater: CaseIterable {
    case lotteCinema
    case megaBox
    case cgv
    case total
    
    var description: String {
        switch self {
        case .lotteCinema:
            return "롯데시네마"
        case .megaBox:
            return "메가박스"
        case .cgv:
            return "CGV"
        case .total:
            return "전체보기"
        }
    }
}
