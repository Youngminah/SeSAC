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
    
    lazy var provider: MoyaProvider<SesacTarget> = {
        let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
        return MoyaProvider<SesacTarget>(plugins: [authPlugin])
    }()

    init() { }

    func requestRegister(
        username: String,
        email: String,
        password: String,
        completion: @escaping (Result<RegisterInfo.Response, Error>) -> Void
    ) {
        let parameters = [ "username": username, "email": email, "password": password]
        provider.request(.register(parameters: parameters)) { result in
            self.process(type: RegisterInfo.Response.self, result: result, completion: completion)
        }
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
