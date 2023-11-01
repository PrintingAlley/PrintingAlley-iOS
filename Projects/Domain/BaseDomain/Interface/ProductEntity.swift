//
//  ProdcutEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public struct ProductEntity {
    
    public let id: Int
    public let name, priceInfo, introduction, description: String
    public let mainImage: String
    public let images: [String]
    public let category: CategoryEntity
    public let printShop: PrintShopEntity
    public let tags: [ChildrenTagEntity]
    public let reviews: [ReviewEntity]
    
    let statusCode: Int
    let message: String
    
    public init(id: Int, name: String, priceInfo: String, introduction: String, description: String, mainImage: String, images: [String], category: CategoryEntity, printShop: PrintShopEntity, tags: [ChildrenTagEntity], reviews: [ReviewEntity], statusCode: Int, message: String) {
        self.id = id
        self.name = name
        self.priceInfo = priceInfo
        self.introduction = introduction
        self.description = description
        self.mainImage = mainImage
        self.images = images
        self.category = category
        self.printShop = printShop
        self.tags = tags
        self.reviews = reviews
        self.statusCode = statusCode
        self.message = message
    }
    
}
