//
//  ProductListResponseDTO.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import ProductDomainInterface


struct ProductListResponseDTO: Decodable {
    let products: [ProductResponseDTO]
    let statusCode: Int?
    let message: String?
    
    func toDomain() -> ProductListEntity {
        ProductListEntity(statusCode: statusCode ?? 0, message: message ?? "", products: products.map({$0.toDomain()}) )
    }
}
