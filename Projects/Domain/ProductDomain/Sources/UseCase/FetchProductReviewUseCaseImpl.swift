//
//  FetchProductReviewUseCaseImpl.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ProductDomainInterface
import RxSwift
import BaseDomainInterface

struct FetchProductReviewUseCaseImpl: FetchProductReviewUseCase {
    
    
    private let productRepository: any ProductRepository
    
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    
    func execute(id: Int) -> Single<[ProductReviewEntity]> {
        productRepository.fetchReviews(id: id)
    }
    
}

