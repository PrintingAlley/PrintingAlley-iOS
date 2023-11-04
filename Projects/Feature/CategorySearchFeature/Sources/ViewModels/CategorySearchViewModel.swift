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
import PrintShopDomainInterface
import ProductDomainInterface

class CategorySearchViewModel: ViewModelType {

    public var title: String!
    public var id: Int!
    
    public var ids: [Int] = []
   
    let disposeBag = DisposeBag()
    
    var fetchPrintShopListUseCase: any FetchPrintShopListUseCase
    
    var fetchProductListUseCase: any FetchProductListUseCase
    
    init(title: String, id: Int, fetchPrintShopListUseCase: FetchPrintShopListUseCase, fetchProductListUseCase: FetchProductListUseCase) {
        self.title = title
        self.id = id
        self.fetchPrintShopListUseCase = fetchPrintShopListUseCase
        self.fetchProductListUseCase = fetchProductListUseCase
        ids.append(id)
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    public struct Input {
        
    }
    public struct Output {
        let dataSource: BehaviorRelay<ProductListEntity> = .init(value: ProductListEntity(statusCode: 0, message: "", products: []))
        let runIndicator: BehaviorRelay<Void> = .init(value: ())
    }
     
    public func transform(input: Input) -> Output {
    
        let output = Output()
        
        fetchProductListUseCase // infinite scroll 구현
            .execute(page: 1, text: "", tagIds: ids)
            .catchAndReturn(.makeErrorEntity())
            .asObservable()
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        return output
    }
    
}
