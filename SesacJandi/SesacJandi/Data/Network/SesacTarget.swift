//
//  SesacAPI.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import Moya

typealias JsonType = [String: Any]

enum SesacTarget {
    
    // Auth
    case register(parameters: JsonType)
    case login(parameters: JsonType)
    case changePassword(parameters: JsonType)
    
    // Post
    case allPost
    case composePost(parameters: JsonType)
    case updatePost(index: Int, parameters: JsonType)
    case deletePost(index: Int)
    
    // Comment
    case allComment
    case createComment(parameters: JsonType)
    case updateComment(index: Int, parameters: JsonType)
    case deleteComment(index: Int)
}

extension SesacTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.environment.rawValue) else {
            fatalError("fatal error - invalid url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .register:
            return "auth/local/register"
        case .login:
            return "auth/local"
        case .changePassword:
            return "custom/change-password"
        case .allPost,
             .composePost:
            return "comments"
        case .updatePost(index: let index, parameters: _):
            return "comments/\(index)"
        case .deletePost(index: let index):
            return "comments/\(index)"
        case .allComment,
             .createComment:
            return "posts"
        case .updateComment(index: let index, parameters: _):
            return "posts/\(index)"
        case .deleteComment(index: let index):
            return "posts/\(index)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register,
             .login,
             .changePassword,
             .composePost,
             .createComment:
            return .post
        case .allPost,
             .allComment:
            return .get
        case .updatePost,
             .updateComment:
            return .put
        case .deletePost,
             .deleteComment:
            return .delete
        }
    }
    
//    public var sampleData: Data {
//        return stubDate(self)
//    }
    
    var task: Task {
        switch self {
        case .allPost,
             .allComment,
             .deletePost ,
             .deleteComment:
            return .requestPlain
        case .register(let parameters),
             .login(let parameters),
             .changePassword(let parameters),
             .composePost(let parameters),
             .updatePost(_, let parameters),
             .createComment(let parameters),
             .updateComment(_, let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .register,
             .login:
            return .none
        default:
            return .bearer
        }
    }
}
