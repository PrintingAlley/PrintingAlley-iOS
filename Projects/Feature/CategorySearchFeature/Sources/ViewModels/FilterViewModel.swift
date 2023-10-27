//
//  FilterViewModel.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/27/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import RxSwift
import RxRelay
import BaseDomainInterface

class FilterViewModel: ViewModelType {
    
    var id: Int!
    
    let disposeBag = DisposeBag()
    
    let dataSource:BehaviorRelay<[ChildrenTagEntity]> = .init(value: [])
    
    init(id: Int) {
        self.id = id
    }
    
    public struct Input {
        
    }
    
    public struct Output {
        
    }
    
    
    func transform(input: Input) -> Output {
        
        let output = Output()
        
        
        return output
    }
    
    
}
