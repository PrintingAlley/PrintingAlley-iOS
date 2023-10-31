//
//  ProductReviewResponseDTO.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import ProductDomainInterface

struct ProductReviewResponseDTO: Decodable {
    
    let productReviews:[ReviewResponseDTO]
    let user: FetchUserInfoResponseDTO
    let statusCode: Int?
    let message: String?
    
    func toDomain() -> ProductReviewEntity  {
        ProductReviewEntity(productReviews: productReviews.map{$0.toDomain()}, user: user.toDomain(), statusCode: statusCode ?? 0, message: message ?? "")
    }
        
}
