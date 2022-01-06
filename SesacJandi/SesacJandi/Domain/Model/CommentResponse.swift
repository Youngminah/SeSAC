//
//  CommentResponse.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation

// MARK: - Comment
struct CommentResponse: Codable {
    let id: Int
    let comment: String
    let user: User
    let post: Post
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
    }
}

struct Post: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
    }
}
