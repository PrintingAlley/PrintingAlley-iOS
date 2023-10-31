//
//  BookMarkEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct BookMarkEntity {
    public let id: Int
    public let product: ProductEntity
    public let tags: [ChildrenTagEntity]
    
    public init(id: Int, product: ProductEntity, tags: [ChildrenTagEntity]) {
        self.id = id
        self.product = product
        self.tags = tags
    }

}
