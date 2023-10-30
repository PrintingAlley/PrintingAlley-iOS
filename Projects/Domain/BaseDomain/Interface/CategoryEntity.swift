//
//  CategoryEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//


import Foundation

public struct CategoryEntity {
    let id: Int
    let name: String
    let image: String
    let statusCode: Int
    let message: String
    
    public init(id: Int, name: String, image: String, statusCode: Int, message: String) {
        self.id = id
        self.name = name
        self.image = image
        self.statusCode = statusCode
        self.message = message
    }
    
}
