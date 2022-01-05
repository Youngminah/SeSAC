//
//  NetworkService.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

enum DecodeError: Error {
    case decodeError
}

class NetworkService {
    
    let tokenClosure: (TargetType) -> String = { _ in
        return TokenUtils.read(AppConfiguration.service, account: "accessToken") ?? ""
    }
    
    var provider: MoyaProvider<SesacTarget>

    init(provider: MoyaProvider<SesacTarget>) {
        self.provider = provider
    }

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
