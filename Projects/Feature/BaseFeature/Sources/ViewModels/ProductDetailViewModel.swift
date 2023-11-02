//
//  ProductDetailViewModel.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import BaseDomainInterface
import RxSwift
import RxRelay
import ProductDomainInterface

public struct ProductHeaderInfo {
    let id: Int
    let title: String
    let subtitle: String
}

struct ProductDataInfo {
    let dataSoruce: [String]
}

final class ProductDetailViewModel: ViewModelType {
    
    var id: Int!
    let disposeBag = DisposeBag()
    var fetchProductUseCase: any FetchProductUseCase
    var isSaved: Bool = false
    
    init(id: Int,fetchProductUseCase : FetchProductUseCase) {
        self.id = id
        self.fetchProductUseCase = fetchProductUseCase
    }
    
    struct Input {
        let askToast: PublishSubject<BaseEntity> = .init()
        let fetchData: PublishSubject<Void> = .init()
    }
    
    struct Output {
        let showToast: PublishSubject<BaseEntity> = .init()
        let headerInfo: BehaviorRelay<ProductHeaderInfo> = .init(value:  ProductHeaderInfo(id: 0, title: "", subtitle: ""))
        let dataInfo: BehaviorRelay<ProductDataInfo> = .init(value: ProductDataInfo(dataSoruce: []))
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.askToast
            .bind(to:output.showToast)
            .disposed(by: disposeBag)
        
        input.fetchData
            .flatMap({ [weak self] _ -> Observable<ProductEntity> in
                
                guard let  self else {return Observable.empty()}
                
                return self.fetchProductUseCase
                    .execute(id: id)
                    .catchAndReturn(ProductEntity.makeErrorEntity(message: ""))
                    .asObservable()
            })
            .do(onNext: {
                if $0.statusCode == 400 {
                    input.askToast.onNext(BaseEntity(statusCode: 0, message: "알 수 없는 에러가 발생했습니다."))
                }
            })
            .subscribe(onNext: { dataSource in
                
                output.headerInfo.accept(ProductHeaderInfo(id: dataSource.id, title: "템프", subtitle: "템프2"))
                output.dataInfo.accept(ProductDataInfo(dataSoruce: ["1","2","3","4","5"]))
            })
            .disposed(by: disposeBag)
            
        
        return output
    }
}
