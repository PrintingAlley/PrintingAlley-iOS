//
//  ProductDomainFactory.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public protocol ProductDomainFactory {
    var fetchProductListUseCase: any FetchProductListUseCase { get }
    var fetchProductUseCase: any FetchProductUseCase { get }
    var createReviewUseCase: any CreateReviewUseCase { get }
    var editReviewUseCase: any EditReviewUseCase { get }
    var deleteReviewUseCase: any DeleteReviewUseCase { get }
    var fetchProductReviewUseCase: any FetchProductReviewUseCase { get }
}
