//
//  NetworkService+Generic.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import Moya

extension NetworkService {

    func process<T: Codable, E>(
        type: T.Type,
        result: Result<Response, MoyaError>,
        completion: @escaping (Result<E, Error>) -> Void
    ) {
        switch result {
        case .success(let response):
            if let data = try? JSONDecoder().decode(type, from: response.data) {
                completion(.success(data as! E))
            } else {
                completion(.failure(DecodeError.decodeError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
