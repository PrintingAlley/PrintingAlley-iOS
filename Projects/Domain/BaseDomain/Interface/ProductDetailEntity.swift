//
//  ProductDetailEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 11/4/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public struct ProductDetailEntity  {
    public let product: ProductEntity
    public let statusCode: Int
    public let message: String
    
    
    public init(product: ProductEntity, statusCode: Int, message: String) {
        self.product = product
        self.statusCode = statusCode
        self.message = message
    }
    
    public static func makeErrorEntity() -> Self {
        ProductDetailEntity(product: ProductEntity.makeErrorEntity(message: ""), statusCode: 400, message: "")
    }
}
