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
    
    let statusCode: Int
    let message: String
    
    let products: [ProductEntity]
    
    
    public init(statusCode: Int, message: String, products: [ProductEntity]) {
        self.statusCode = statusCode
        self.message = message
        self.products = products
    }
    
}
