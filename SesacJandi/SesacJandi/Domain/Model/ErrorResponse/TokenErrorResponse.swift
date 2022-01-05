//
//  GetError.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

struct TokenErrorResponse: Codable {
    let statusCode: Int
    let error: String
    let message: String
}
