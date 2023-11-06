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
   
    let disposeBag = DisposeBag()
    
    var fetchProductListUseCase: any FetchProductListUseCase
    
    init(title: String, id: Int, fetchProductListUseCase: FetchProductListUseCase) {
        self.title = title
        self.id = id
        self.fetchProductListUseCase = fetchProductListUseCase
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    public struct Input {
        let fetchData: PublishSubject<Void> = .init()
    }

    public struct Output {
        let dataSource: BehaviorRelay<ProductListEntity> = .init(value: ProductListEntity(statusCode: 0, message: "", products: []))
        let runIndicator: BehaviorRelay<Void> = .init(value: ())
        let tags: BehaviorRelay<[Tag]> = .init(value: [])
    }
     
    public func transform(input: Input) -> Output {
    
        let output = Output()
        
        input.fetchData
            .withLatestFrom(output.tags)
            .map { $0.map { $0.id } }
            .flatMap { [weak self] tags -> Observable<ProductListEntity> in
                guard let self else { return Observable.empty() }
                return self.fetchProductListUseCase
                    .execute(page: 1, text: "", tagIds: tags + [self.id])
                    .catchAndReturn(.makeErrorEntity())
                    .asObservable()
            }
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        return output
    }
    
}
