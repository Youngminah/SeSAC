//
//  RegisterInfo.swift
//  SesacJandi
//
//  Created by meng on 2022/01/04.
//

import Foundation

struct RegisterInfo: Codable {

    struct Response: Codable {
        let jwt: String
        let user: User
    }
}

struct User: Codable {
    let id: Int
    let username: String
    let email: String
}

struct ErrorAPI: Codable {
    let statusCode: Int
    let message: [ErrorData]
}

struct ErrorData: Codable {
    let messages: [ErrorMessage]
}

struct ErrorMessage: Codable {
    let id: String
    let message: String
}

