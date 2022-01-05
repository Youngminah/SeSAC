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

struct NetworkService {
    
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

// MARK: - RX
extension NetworkService {
    func requestRegister(username: String, email: String, password: String) -> Single<RegisterInfo.Response> {
        return Single.create(subscribe: { observer -> Disposable in
            requestRegister(username: username, email: email, password: password) { result in
                switch result {
                case .success(let response):
                    observer(.success(response))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        })
    }
}
