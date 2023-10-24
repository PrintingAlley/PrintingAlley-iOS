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

public struct HierarchyResponseDTO : Decodable { // Decodable no
    let hierarchies: [ChildrenTagResponseDTO]
    let statusCode: Int?
    let message: String?
    
    public func toDomain() -> HierarchyEntity {
        HierarchyEntity(statusCode: statusCode ?? 0, message: message ?? "",hierarchies: hierarchies.map{$0.toDomain()})
    }
}
