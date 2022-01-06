//
//  PrimitiveSequence.swift
//  SesacJandi
//
//  Created by meng on 2022/01/05.
//

import Foundation
import RxSwift
import RxMoya
import Moya
import RxCocoa

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func catchSessacError(_ type: SessacErrorCase.Type) -> Single<Element> {
        return flatMap { response in
            guard (200...299).contains(response.statusCode) else {
                do {
                    let errorResponce = try response.map(InputErrorResponse.self)
                    throw SessacErrorCase(messageId: errorResponce.message[0].messages[0].id)
                } catch {
                    throw error
                }
            }
            return .just(response)
        }
    }
}
