//
//  CategorySearchViewModel.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import DesignSystem
import RxSwift
import RxRelay
import BaseDomainInterface
import SearchDomainInterface

class CategorySearchViewModel: ViewModelType {

    public var title: String!
    public var id: Int!
    
    let disposeBag = DisposeBag()
    
    var fetchPrintShopListUseCase :  any FetchPrintShopListUseCase
    
    
    init(title: String, id: Int, fetchPrintShopListUseCase : FetchPrintShopListUseCase) {
        self.title = title
        self.id = id
        self.fetchPrintShopListUseCase = fetchPrintShopListUseCase
    }
    
    public struct Input {
        
    }
    public struct Output {
        let dataSource: BehaviorRelay<[PrintShopEntity]> = .init(value: [])
    }
    
    
    public func transform(input: Input) -> Output {
    
        let output = Output()
        
        fetchPrintShopListUseCase
            .execute(searchText: "", tagIds: [id])
            .catchAndReturn([])
            .asObservable()
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
            
        
        
        
        return output
    }
    
}
