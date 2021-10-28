//
//  DataManager.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//
import Alamofire

final class DataManager {
    
    static let shared = DataManager()
    
    func fetchMovieData(completion: @escaping (TvShow?, Error?) -> ()) {
        
        let url = "\(Endpoint.baseURL)/movie/day?api_key=\(APIKey.TMDB)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: TvShow.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    let mapAnnotations: [TheaterLocation] = [
        TheaterLocation(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        TheaterLocation(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        TheaterLocation(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        TheaterLocation(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        TheaterLocation(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        TheaterLocation(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
}
