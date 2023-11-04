//
//  ProductDetailResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 11/4/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct ProductDetailResponseDTO: Decodable  {
    public let product: ProductResponseDTO
    public let statusCode: Int?
    public let message: String?
    
    
    
    public func toDomain() -> ProductDetailEntity {
        
        ProductDetailEntity(product: product.toDomain(), statusCode: statusCode ?? 0, message: message ?? "")
    }
    
  
}
