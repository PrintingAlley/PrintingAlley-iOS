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

final class HomeViewModel: ViewModelType {
    
    var fetchTagUseCase: any FetchTagUseCase
    var fetchHierarchyUseCase: any FetchHierarchyUseCase
    
    let disposeBag = DisposeBag()
    
    init(fetchTagUseCase: FetchTagUseCase, fetchHierarchyUseCase: FetchHierarchyUseCase) {
        self.fetchTagUseCase = fetchTagUseCase
        self.fetchHierarchyUseCase = fetchHierarchyUseCase
    }
    
    public struct Input {
        let viewDidLoad: PublishSubject<Void> = .init()
    }
    
    public struct Output{
        let tagDataSource: BehaviorRelay<[ChildrenTagEntity]> = .init(value: [])
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoad
            .flatMap({ [weak self] () -> Observable<[ChildrenTagEntity]> in
                
                guard let self else { return Observable.empty()}
                
                return self.fetchHierarchyUseCase.execute()
                    .catch({ error in
                        
                        return Single<HierarchyEntity>.create { single in
                            single(.success(HierarchyEntity(statusCode: 0, message: "", hierarchies: [])))
                            return Disposables.create()
                        }
                    })
                    .map{$0.hierarchies}
                    .asObservable()
                
            })
            .bind(to: output.tagDataSource)
            .disposed(by: disposeBag)
        
        return output
    }
    
}
