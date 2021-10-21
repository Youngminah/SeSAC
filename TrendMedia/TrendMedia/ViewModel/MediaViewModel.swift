//
//  MediaViewModel.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import Foundation

final class MediaViewModel {
    
    private let tvShowList: [TvShow] = DataManager.shared.tvShow
    
    func getTvShow(at index: Int) -> TvShow {
        return tvShowList[index]
    }
    
    func tvShowListCount() -> Int {
        return tvShowList.count
    }
}
