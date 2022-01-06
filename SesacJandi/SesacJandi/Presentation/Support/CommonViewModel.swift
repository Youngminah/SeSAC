//
//  SesacAPI.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import Moya

class CommonViewModel {
    
    let provider: MoyaProvider<SesacTarget>

    init() {
        provider = MoyaProvider<SesacTarget>()
    }
}

extension CommonViewModel {

    func process<T: Codable, E>(
        type: T.Type,
        result: Result<Response, MoyaError>,
        completion: @escaping (Result<E, Error>) -> Void
    ) {
        switch result {
        case .success(let response):
            if response.statusCode == 400 {
                let errorResponse = try! response.map(InputErrorResponse.self)
                completion (.failure(SessacErrorCase(messageId: errorResponse.message[0].messages[0].id)))
            } else if response.statusCode >= 401 {
                TokenUtils.delete(AppConfiguration.service, account: "accessToken")
                let errorResponse = try! response.map(AccessErrorResponse.self)
                completion (.failure(SessacErrorCase(messageId: errorResponse.error)))
            } else {
                let data = try! JSONDecoder().decode(type, from: response.data)
                completion(.success(data as! E))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
