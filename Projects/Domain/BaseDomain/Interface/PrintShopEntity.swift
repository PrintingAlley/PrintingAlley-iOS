//
//  PrintShopEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/23/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


// MARK: - PrintShop
public struct PrintShopEntity {
    public let id: Int
    public let name, address, phone, email: String
    public let homepage: String
    public let representative, introduction: String
    public let logoImage, backgroundImage: String
    public let latitude, longitude: String
    public let products: [ProductEntity]
    
    public init(id: Int, name: String, address: String, phone: String, email: String, homepage: String, representative: String, introduction: String, logoImage: String, backgroundImage: String, latitude: String, longitude: String, products: [ProductEntity]) {
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
        self.products = products
    }
    
    public static func makeErrorEntity() -> PrintShopEntity {
        PrintShopEntity(id: 0, name: "", address: "", phone: "", email: "", homepage: "", representative: "", introduction: "", logoImage: "", backgroundImage: "", latitude: "", longitude: "",products: [])
    }
}
