//
//  BookMarkGroupResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Foundation
import BookMarkDomainInterface
import BaseDomain
import BaseDomainInterface

public struct BookMarkResponseDTO: Decodable {
    let id: Int
    let product: ProductResponseDTO
    let tags: [ChildrenTagResponseDTO]?
    

 
    public func toDomain() -> BookMarkEntity {
        BookMarkEntity(id: id, product: product.toDomain(), tags: tags?.map{$0.toDomain()} ?? [])
    }
}
