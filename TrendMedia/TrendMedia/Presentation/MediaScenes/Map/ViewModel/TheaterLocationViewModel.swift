//
//  TheaterLocationViewModel.swift
//  TrendMedia
//
//  Created by meng on 2021/10/21.
//

import Foundation

final class TheaterLocationViewModel {
    
    private let mapTheaterList: [TheaterLocation] = DataManager.shared.mapAnnotations
    
    var allTheaterList: [TheaterLocation] {
        return mapTheaterList
    }
    
    func getTheater(at index: Int) -> TheaterLocation {
        return mapTheaterList[index]
    }
    
    func annotationListCount() -> Int {
        return mapTheaterList.count
    }
    
    func getBrandTheaters(brand type: String) -> [TheaterLocation] {
        var annotationList = [TheaterLocation]()
        mapTheaterList.forEach {
            if $0.type == type {
                annotationList.append($0)
            }
        }
        return annotationList
    }
}
