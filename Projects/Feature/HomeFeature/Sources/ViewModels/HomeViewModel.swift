//
//  HomeViewModel.swift
//  HomeFeatureInterface
//
//  Created by 박의서 on 2023/10/11.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import TagDomainInterface
import RxRelay
import RxSwift
import BaseDomainInterface
import ContentDomainInterface

final class HomeViewModel: ViewModelType {
    
    var fetchHierarchyUseCase: any FetchHierarchyUseCase
    var fetchContentsUseCase: any FetchContentsUseCase
    
    let disposeBag = DisposeBag()
    
    init(fetchHierarchyUseCase: FetchHierarchyUseCase,fetchContentsUseCase : FetchContentsUseCase) {
        self.fetchHierarchyUseCase = fetchHierarchyUseCase
        self.fetchContentsUseCase = fetchContentsUseCase
    }
    
    public struct Input {
        
    }
    
    public struct Output{
        let tagDataSource: BehaviorRelay<[ChildrenTagEntity]> = .init(value: [])
        let contentDataSource: BehaviorRelay<[ContentEntity]> = .init(value: [])
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
            
        let dataSourceForZip =  Observable.zip(
            fetchHierarchyUseCase.execute()
                .catchAndReturn(HierarchyEntity(statusCode: 0, message: "", hierarchies: []))
                .asObservable(),
            fetchContentsUseCase.execute()
                .catchAndReturn(ContentGroupEntity(contents: [], statusCode: 0, message: ""))
                .asObservable()
        )
        
        dataSourceForZip
            .subscribe(onNext: { (tagsResult,contentResult) in
                
                output.tagDataSource.accept(tagsResult.hierarchies)
                output.contentDataSource.accept(contentResult.contents)
                
            })
            .disposed(by: disposeBag)
        

        
        return output
    }
    
}
