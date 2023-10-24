//
//  HierarchyEntity.swift
//  TagDomainInterface
//
//  Created by yongbeomkwak on 10/23/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct HierarchyEntity  { // Decodable no
   public let hierarchies: [ChildrenTagEntity]
    
    let statusCode: Int
    let message: String
    
    public init(statusCode: Int, message: String, hierarchies: [ChildrenTagEntity]) {
        self.hierarchies = hierarchies
        self.statusCode = statusCode
        self.message = message
    }
}
