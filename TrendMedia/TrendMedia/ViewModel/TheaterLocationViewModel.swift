//
//  TheaterLocationViewModel.swift
//  TrendMedia
//
//  Created by meng on 2021/10/21.
//

import Foundation

final class TheaterLocationViewModel {
    
    private let mapAnnotationsList: [TheaterLocation] = DataManager.shared.mapAnnotations
    
    func getAnnotation(at index: Int) -> TheaterLocation {
        return mapAnnotationsList[index]
    }
    
    func annotationListCount() -> Int {
        return mapAnnotationsList.count
    }
    
    func getBrandAnnotations(brand type: String) -> [TheaterLocation] {
        var annotationList = [TheaterLocation]()
        mapAnnotationsList.forEach {
            if $0.type == type {
                annotationList.append($0)
            }
        }
        return annotationList
    }
}
