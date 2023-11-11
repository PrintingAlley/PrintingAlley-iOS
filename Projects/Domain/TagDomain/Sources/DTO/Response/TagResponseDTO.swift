//
//  TagResponseDTO.swift
//  TagDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import TagDomainInterface
import BaseDomain
import BaseDomainInterface

public struct TagResponseDTO : Decodable { // Decodable no
    
    let tag: ChildrenTagResponseDTO
    let statusCode: Int?
    let message: String?
    
    public func toDomain() -> TagEntity {
        TagEntity(tag: tag.toDomain(), statusCode: statusCode ?? 0, message: message ?? "")
    }
}
