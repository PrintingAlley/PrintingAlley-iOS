//
//  PrintShopListEntity.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct PrintShopListEntity {
    let id: Int
    let image: String?
    let name: String
    let tags: [String]
    let introduction: String
    let address: String

    public init(id: Int, image: String?, name: String, tags: [String], introduction: String, address: String) {
        self.id = id
        self.image = image
        self.name = name
        self.tags = tags
        self.introduction = introduction
        self.address = address
    }
}
