//
//  MediaViewModel.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//

import Foundation

final class MediaViewModel {
    
    private var dataManager: DataManager?
    private var movieList: [Movie]? { didSet { self.didFinishFetch?() } }
    
    //MARK: 프로퍼티 DidSet
    var error: Error? { didSet { self.showAlertClosure?() } }
    var failMessage: String? { didSet { self.showAlertClosure?() } }
    var failCode: Int? { didSet { self.codeAlertClosure?() } }
    var isLoading: Bool = false { didSet { self.updateLoadingStatus?() } }
    
    //MARK: 클로져
    var showAlertClosure: (() -> ())?
    var codeAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: 생성자
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func getTvShow(at index: Int) -> Movie? {
        return movieList?[index]
    }
    
    func tvShowListCount() -> Int {
        return movieList?.count ?? 0
    }
    
    func requestFetchMovieData() {
        self.dataManager?.fetchMovieData(completion: { [weak self] response, error in
            guard let strongself = self else { return }
            if let error = error {
                strongself.error = error
                return
            }
            strongself.movieList = response?.results
        })
    }
}
