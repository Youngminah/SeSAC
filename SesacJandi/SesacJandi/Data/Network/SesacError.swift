//
//  SesacError.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation

enum SessacError: Error {
    
    case emailIsAlreadyTaken
    case inValidateEmailAddress
    case unknown
    case with(messageId: String)
    
    init(messageId: String) {
        print(messageId)
        switch messageId {
        case "Auth.form.error.email.taken": self = .emailIsAlreadyTaken
        case "Auth.form.error.email.format": self = .inValidateEmailAddress
        default: self = messageId.isEmpty ? .unknown : .with(messageId: messageId)
        }
    }
}

extension SessacError {
    var errorDescription: String {
        switch self {
        case .emailIsAlreadyTaken:
            print("dd")
            return "이미 가입된 이메일 입니다."
        case .inValidateEmailAddress:
            return "이메일이 유효하지 않습니다."
        case .unknown:
            return "올바른 입력 값이 아닙니다."
        case .with(let messageId):
            print("dd")
            return "\(messageId)"
        }
    }
}
