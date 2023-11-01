//
//  PrintShopReviewEntity.swift
//  PrintShopDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct PrintShopReviewEntity {
    public let id: Int
    public let name, address, phone, email: String
    public let homepage: String
    public let representative, introduction: String
    public let logoImage, backgroundImage: String
    public let latitude, longitude: Double
    public let createdAt, updateAt: String
    public let user: UserInfoEntity
    
    public init(id: Int, name: String, address: String, phone: String, email: String, homepage: String, representative: String, introduction: String, logoImage: String, backgroundImage: String, latitude: Double, longitude: Double, createdAt: String, updateAt: String, user: UserInfoEntity) {
        self.id = id
        self.name = name
        self.address = address
        self.phone = phone
        self.email = email
        self.homepage = homepage
        self.representative = representative
        self.introduction = introduction
        self.logoImage = logoImage
        self.backgroundImage = backgroundImage
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.updateAt = updateAt
        self.user = user
    }
}

