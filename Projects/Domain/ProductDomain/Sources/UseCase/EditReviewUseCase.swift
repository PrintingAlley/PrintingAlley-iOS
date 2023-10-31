//
//  EditReviewUseCase.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ProductDomainInterface
import RxSwift
import BaseDomainInterface

struct EditReviewUseCaseImpl: EditReviewUseCase {

    
    private let productRepository: any ProductRepository
    
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func execute(id: Int, reviewId: Int, content: String, rating: Int, images: [String]) -> Single<BaseEntity> {
        productRepository.editReview(id: id, reviewId: reviewId, content: content, rating: rating, images: images)
    }
    
    

    
    

}
