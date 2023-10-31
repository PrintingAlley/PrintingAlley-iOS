//
//  FetchProductListUseCaseImpl.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ProductDomainInterface
import RxSwift
import BaseDomainInterface

struct FetchProductListUseCaseImpl: FetchProductListUseCase {
    
    private let productRepository: any ProductRepository
    
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    
    func execute(page: Int, text: String, tagIds: [Int]) -> Single<ProductListEntity> {
     
        productRepository.fetchProductList(page: page, text: text, tagIds: tagIds)
    }
}
