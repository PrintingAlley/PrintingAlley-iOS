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
        var pageID: PublishRelay<(Int)> = .init()
        var loadMore: PublishSubject<Void> = .init()
        var isFetchByScroll: BehaviorRelay<Bool> = .init(value: false)
    }

    public struct Output {
        let dataSource: BehaviorRelay<[ProductEntity]> = .init(value: [])
        let runIndicator: BehaviorRelay<Void> = .init(value: ())
        let tags: BehaviorRelay<[Tag]> = .init(value: [])
        var canLoadMore: BehaviorRelay<Bool> = .init(value: true)
    }
     
    public func transform(input: Input) -> Output {
        let output = Output()
        
        let refresh = Observable.combineLatest(output.dataSource, input.pageID) { (dataSource, pageID) -> [ProductEntity] in
            return pageID == 1 ? [] : dataSource
        }
        
        input.loadMore
            .withLatestFrom(input.pageID)
            .subscribe(onNext: {
                input.pageID.accept($0+1)
        })
        .disposed(by: disposeBag)
      
        input.pageID
            .withLatestFrom(output.tags){($0,$1)}
            .map { ($0, $1.map { $0.id })}
            .flatMap { [weak self] (page,tags) -> Observable<ProductListEntity> in
                guard let self else { return Observable.empty() }
                
                return self.fetchProductListUseCase
                    .execute(page: page, text: "", tagIds: tags + [self.id])
                    .catchAndReturn(.makeErrorEntity())
                    .asObservable()
            }
            .map { $0.products }
            .do(onNext: { (model) in
                output.canLoadMore.accept(!model.isEmpty)
            }, onError: { _ in
                output.canLoadMore.accept(false)
            })
            .withLatestFrom(refresh, resultSelector: { (newModels, datasources) -> [ProductEntity] in
                return input.isFetchByScroll.value ? datasources + newModels : newModels
            })
                .bind(to: output.dataSource)
                .disposed(by: disposeBag)
        return output
    }
    
}
