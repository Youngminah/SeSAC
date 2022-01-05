//
//  SesacAPI.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import Moya

class SesacAPI {
    
    let tokenClosure: (TargetType) -> String = { _ in
        return TokenUtils.read(AppConfiguration.service, account: "accessToken") ?? ""
    }
    
    let provider: MoyaProvider<SesacTarget>

    init() {
        let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
        provider = MoyaProvider<SesacTarget>(plugins: [authPlugin])
    }
}

extension SesacAPI {

    func process<T: Codable, E>(
        type: T.Type,
        result: Result<Response, MoyaError>,
        completion: @escaping (Result<E, Error>) -> Void
    ) {
        switch result {
        case .success(let response):
            guard (200...299).contains(response.statusCode) else {
                let errorResponce = try! response.map(ErrorAPI.self)
                completion (.failure(SessacError(messageId: errorResponce.message[0].messages[0].id)))
                return
            }
            let data = try! JSONDecoder().decode(type, from: response.data) 
            completion(.success(data as! E))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
