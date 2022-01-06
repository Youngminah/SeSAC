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
    static let environment: APIEnvironment = .staging
}
