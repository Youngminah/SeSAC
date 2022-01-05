//
//  GetError.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

struct AccessErrorResponse: Codable {
    let statusCode: Int
    let error: String
    let message: String
}
