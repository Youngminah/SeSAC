//
//  ViewModelType.swift
//  SesacJandi
//
//  Created by meng on 2022/01/06.
//

import Foundation
import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
