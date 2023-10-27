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
import TagDomainInterface

class FilterViewModel: ViewModelType {
    
    var id: Int!
    
    let disposeBag = DisposeBag()
    
    let dataSource:BehaviorRelay<[ChildrenTagEntity]> = .init(value: [])
    
    var fetchTagUseCase: any FetchTagUseCase
    
    init(id: Int, fetchTagUseCase: FetchTagUseCase) {
        self.id = id
        self.fetchTagUseCase = fetchTagUseCase
        

        
    }
    
    public struct Input {
        
    }
    
    public struct Output {
        
    }
    
    
    func transform(input: Input) -> Output {
        
        let output = Output()
        
        
        fetchTagUseCase
            .execute(id: id)
            .catchAndReturn(ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: []))
            .asObservable()
            .map{$0.children}
            .bind(to:self.dataSource)
            .disposed(by: disposeBag)
        
        return output
    }
    
    
}
