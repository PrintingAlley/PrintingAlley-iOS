//
//  CategoryResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct CategoryResponseDTO: Decodable {
    let id: Int
    let name: String
    let image: String?
    let statusCode: Int?
    let message: String? 
    
    
    func toDomain() -> CategoryEntity {
        CategoryEntity(id: id, name: name, image: image ?? "", statusCode: statusCode ?? 0, message: message ?? "")
    }
    
}
