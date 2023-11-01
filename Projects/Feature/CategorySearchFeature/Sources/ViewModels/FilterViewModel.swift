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
    public var fillterIdSet:Set<Int> = .init()
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
            .catchAndReturn(TagEntity(tag: ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: []), statusCode: 0, message: ""))
            .asObservable()
            .map{$0.tag.children}
            .bind(to:self.dataSource)
            .disposed(by: disposeBag)
        
        
        NotificationCenter.default.rx.notification(.filterToggle)
            .subscribe(onNext: { [weak self] (notification) in
                
                guard let self else {return}
                guard let id = notification.object as? Int else { return }
                
                if self.fillterIdSet.contains(id) {
                    self.fillterIdSet.remove(id)
                } else {
                    self.fillterIdSet.insert(id)
                }
                
                DEBUG_LOG(self.fillterIdSet)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    
}
