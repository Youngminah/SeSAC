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
    let user, post: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
    }
}
