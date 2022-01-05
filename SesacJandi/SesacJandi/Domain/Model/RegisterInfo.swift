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

