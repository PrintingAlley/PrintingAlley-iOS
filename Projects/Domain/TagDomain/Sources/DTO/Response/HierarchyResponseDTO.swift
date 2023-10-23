//
//  HierarchyResponseDTOEntity.swift
//  TagDomain
//
//  Created by yongbeomkwak on 10/23/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import TagDomainInterface
import BaseDomain

struct HierarchyResponseDTO : Decodable { // Decodable no
    let id: Int
    let name: String
    let image: String
    let parent: String
    let children: [String]
    let printShops: [PrintShopResponseDTO]
    let statusCode: Int?
    let message: String?
    
    
    func toDomain() -> HierarchyEntity {
        HierarchyEntity(id: id, name: name, image: image, parent: parent, children: children, printShops: printShops.map{$0.toDomain()},statusCode: statusCode ?? 0, message: message ?? "")
    }

    
}
