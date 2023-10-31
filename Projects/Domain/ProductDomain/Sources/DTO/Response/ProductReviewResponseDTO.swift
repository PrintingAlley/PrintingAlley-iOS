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
    
    let id: Int
    let content: String
    let rating: Int
    let images: [String]
    let user: FetchUserInfoResponseDTO
    let statusCode: Int?
    let message: String?
    
    func toDomain() -> ProductReviewEntity  {
        ProductReviewEntity(id: id, content: content, rating: rating, images: images, user: user.toDomain(), statusCode: statusCode ?? 0, message: message ?? "")
    }
        
}
