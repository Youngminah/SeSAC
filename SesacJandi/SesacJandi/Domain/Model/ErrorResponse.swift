//
//  ErrorResponse.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

struct ErrorResponse: Codable {
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
