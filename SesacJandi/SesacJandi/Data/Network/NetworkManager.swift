//
//  NetworkManager.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import Moya

enum APIEnvironment: String {
    case qa         = "https://qa.com"
    case staging    = "http://test.monocoding.com:1231/"
    case production = "https://production.com"
}

struct NetworkManager {
    
    let tokenClosure: (TargetType) -> String = { _ in
        return TokenUtils.read(AppConfiguration.service, account: "accessToken") ?? ""
    }
    fileprivate var provider : MoyaProvider<SesacTarget> {
        let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
        return MoyaProvider<SesacTarget>(plugins: [authPlugin])
    }
    static let environment: APIEnvironment = .staging
}
