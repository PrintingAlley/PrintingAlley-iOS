//
//  ChildrenTagResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/24/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct ChildrenTagResponseDTO: Decodable {
    let id: Int
    let name: String
    let image: String?
    let parentID: Int?
    let children: [ChildrenTagResponseDTO]?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case parentID = "parent_id"
        case children
    }
    
    public func toDomain() -> ChildrenTagEntity {
    
        return ChildrenTagEntity(id: id, name: name, image: image ?? "", parentID: parentID ?? 0,children: children?.map({$0.toDomain()}) ?? [])
    }
}
