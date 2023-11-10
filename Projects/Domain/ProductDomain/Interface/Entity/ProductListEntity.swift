//
//  ProductListEntity.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct ProductListEntity {
    
    public let statusCode: Int
    public let message: String
    public let products: [ProductEntity]
    public let totalCount: Int
    
    public init(statusCode: Int, message: String, products: [ProductEntity], totalCount: Int) {
        self.statusCode = statusCode
        self.message = message
        self.products = products
        self.totalCount = totalCount
    }
    
    public static func makeErrorEntity() -> Self {
        ProductListEntity(statusCode: 400, message: "", products: [.makeErrorEntity(message: "")], totalCount: 0)
    }
    
}
