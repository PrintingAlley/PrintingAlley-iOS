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
    let id: Int
    let content: String
    let rating: Int
    let images: [String]
    let user: UserInfoEntity
    let statusCode: Int
    let message: String
    
    
    public init(id: Int, content: String, rating: Int, images: [String], user: UserInfoEntity, statusCode: Int, message: String) {
        self.id = id
        self.content = content
        self.rating = rating
        self.images = images
        self.user = user
        self.statusCode = statusCode
        self.message = message
    }
}
