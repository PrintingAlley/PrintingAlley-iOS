//
//  TagEntity.swift
//  TagDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct TagEntity {
    
    public let tag: ChildrenTagEntity
    public let statusCode: Int
    public let message: String
    
    
    public init(tag: ChildrenTagEntity, statusCode: Int, message: String) {
        self.tag = tag
        self.statusCode = statusCode
        self.message = message
    }
    
}
