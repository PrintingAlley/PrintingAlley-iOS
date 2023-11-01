//
//  ReviewRequestDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct ReviewRequestDTO: Encodable {
    let content: String
    let rating: Int
    let images: [String]
    
    public init(content: String, rating: Int, images: [String]) {
        self.content = content
        self.rating = rating
        self.images = images
    }
}
