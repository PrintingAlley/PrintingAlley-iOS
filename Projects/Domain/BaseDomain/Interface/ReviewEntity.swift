//
//  ReviewEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct ReviewEntity{
    let id: Int
    let content: String
    let rating: Int
    let images: [String]
    let statusCode: Int
    let message: String
    
    
    public init(id: Int, content: String, rating: Int, images: [String], statusCode: Int, message: String) {
        self.id = id
        self.content = content
        self.rating = rating
        self.images = images
        self.statusCode = statusCode
        self.message = message
    }
    
    public static func makeErrorEnitity(message: String) -> Self {
        ReviewEntity(id: 0, content: "", rating: 0, images: [], statusCode: 0, message: message)
    }
    
}
