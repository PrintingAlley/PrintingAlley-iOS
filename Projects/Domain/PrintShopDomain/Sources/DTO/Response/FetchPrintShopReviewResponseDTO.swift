//
//  FetchPrintShopReviewResponseDTO.swift
//  PrintShopDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import BaseDomainInterface
import PrintShopDomainInterface

struct FetchPrintShopReviewResponseDTO: Decodable {
    let id: Int
    let name, address, phone, email: String
    let homepage: String
    let representative, introduction: String
    let logoImage, backgroundImage: String
    let latitude, longitude: Double
    let createdAt, updateAt: String
    let user: UserResponseDTO
    
    
    func toDomain() -> PrintShopReviewEntity {
        PrintShopReviewEntity(id: id, name: name, address: address, phone: phone, email: email, homepage: homepage, representative: representative, introduction: introduction, logoImage: logoImage, backgroundImage: backgroundImage, latitude: latitude, longitude: longitude, createdAt: createdAt, updateAt: updateAt, user: user.toDomain())
    }
}
