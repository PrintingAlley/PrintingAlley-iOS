//
//  ProductReviewEntity.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface


public struct ProductReviewEntity {
    let productReviews:[ReviewEntity]
    let user: UserInfoEntity
    let statusCode: Int
    let message: String
    
    public init(productReviews: [ReviewEntity], user: UserInfoEntity, statusCode: Int, message: String) {
        self.productReviews = productReviews
        self.user = user
        self.statusCode = statusCode
        self.message = message
    }
}
