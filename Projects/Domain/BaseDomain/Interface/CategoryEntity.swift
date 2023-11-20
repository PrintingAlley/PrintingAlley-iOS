//
//  CategoryEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//


import Foundation
import UtilityModule

public struct CategoryEntity {
    let id: Int
    public let name: String
    public let image: String
    let statusCode: Int
    let message: String
    
    public init(id: Int, name: String, image: String, statusCode: Int, message: String) {
        self.id = id
        self.name = name
        self.image = image.encodeUrl()!
        self.statusCode = statusCode
        self.message = message
    }
    
    public static func makeErrorEntity() -> Self {
        CategoryEntity(id: 0, name: "", image: "", statusCode: 0, message: "")
    }
    
}
