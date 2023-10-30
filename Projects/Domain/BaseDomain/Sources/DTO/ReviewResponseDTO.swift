//
//  ReviewResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct ReviewResponseDTO: Decodable {
    let id: Int
    let content: String
    let rating: Double
    let images: [String]
    let statusCode: Int?
    let message: String?
    
    
    func toDomain() -> ReviewEntity {
        ReviewEntity(id: id, content: content, rating: rating, images: images, statusCode: statusCode ?? 0, message: message ?? "")
    }
    
}
