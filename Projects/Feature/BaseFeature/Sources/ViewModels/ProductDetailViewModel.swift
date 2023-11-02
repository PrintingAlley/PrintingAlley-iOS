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

final class ProductDetailViewModel: ViewModelType {
    
    var id: Int!
    let disposeBag = DisposeBag()
    
    var fetchProductUseCase: any FetchProductUseCase
    
    init(id: Int,fetchProductUseCase : FetchProductUseCase) {
        self.id = id
        self.fetchProductUseCase = fetchProductUseCase
    }
    
    struct Input {
        let askToast: PublishSubject<BaseEntity> = .init()
    }
    
    struct Output {
        let showToast: PublishSubject<BaseEntity> = .init()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.askToast
            .bind(to:output.showToast)
            .disposed(by: disposeBag)
        
        return output
    }
}
