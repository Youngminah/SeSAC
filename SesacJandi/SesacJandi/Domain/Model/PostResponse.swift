//
//  PostResponse.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

struct PostResponse: Codable {
    let id: Int
    let text: String
    let user: User
    let createdAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case comments
    }
}

struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
    }
}
