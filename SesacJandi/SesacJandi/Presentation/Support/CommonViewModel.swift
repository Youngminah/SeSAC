//
//  SesacAPI.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import Moya

class CommonViewModel {
    
    let tokenClosure: (TargetType) -> String = { _ in
        print()
        return TokenUtils.read(AppConfiguration.service, account: "accessToken") ?? ""
    }
    
    let provider: MoyaProvider<SesacTarget>

    init() {
        let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
        provider = MoyaProvider<SesacTarget>(plugins: [authPlugin])
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
            print("ㅋㅋㅋㅋ")
            print(try! response.mapJSON())
            if response.statusCode == 400 {
                let errorResponse = try! response.map(InputErrorResponse.self)
                completion (.failure(SessacErrorEnum(messageId: errorResponse.message[0].messages[0].id)))
            } else if response.statusCode >= 401 {
                let errorResponse = try! response.map(TokenErrorResponse.self)
                completion (.failure(SessacErrorEnum(messageId: errorResponse.error)))
            } else {
                let data = try! JSONDecoder().decode(type, from: response.data)
                completion(.success(data as! E))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
