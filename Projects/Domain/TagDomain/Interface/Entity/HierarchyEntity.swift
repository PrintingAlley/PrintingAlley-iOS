//
//  HierarchyEntity.swift
//  TagDomainInterface
//
//  Created by yongbeomkwak on 10/23/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct HierarchyEntity { // Decodable no
    public let id: Int
    public let name: String
    public let image: String
    public let parent: String
    public let children: [String]
    public let printShops: [PrintShopEntity]
    public let statusCode: Int
    public let message: String
    
    // init 생성
    
    public init(id: Int, name: String, image: String, parent: String, children: [String], printShops: [PrintShopEntity], statusCode: Int, message: String) {
        self.id = id
        self.name = name
        self.image = image
        self.parent = parent
        self.children = children
        self.printShops = printShops
        self.statusCode = statusCode
        self.message = message
    }
    
}
