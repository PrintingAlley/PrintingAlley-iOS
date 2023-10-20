//
//  BookMarkEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public struct SimplePrintShopInfoEntity {
    public let id: Int
    public let name: String
    public let address: String
    public let tags: [SimpleTagEntity]
    
    public init(id: Int, name: String, address: String, tags: [SimpleTagEntity]) {
        self.id = id
        self.name = name
        self.address = address
        self.tags = tags
    }
}

public struct SimpleTagEntity: Decodable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

