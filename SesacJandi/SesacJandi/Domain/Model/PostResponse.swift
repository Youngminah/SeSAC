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
    let comments: [CommentResponse]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case comments
    }
}
