//
//  PrintShopDetailEntity.swift
//  BaseDomainInterface
//
//  Created by 박의서 on 2023/11/15.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

// MARK: - PrintShop
public struct PrintShopDetailEntity {
    public let id: Int
    public let name, address, phone, email: String
    public let homepage: String
    public let type, printType, afterProcess, businessHours, introduction: String
    public let logoImage, backgroundImage: String
    public let latitude, longitude: String
    public let products: [ProductEntity]
    
    public init(id: Int, name: String, address: String, phone: String, email: String, homepage: String, type: String, printType: String, afterProcess: String, businessHours: String, introduction: String, logoImage: String, backgroundImage: String, latitude: String, longitude: String, products: [ProductEntity]) {
        self.id = id
        self.name = name
        self.address = address
        self.phone = phone
        self.email = email
        self.homepage = homepage
        self.type = type
        self.printType = printType
        self.afterProcess = afterProcess
        self.businessHours = businessHours
        self.introduction = introduction
        self.logoImage = logoImage.encodeUrl()!
        self.backgroundImage = backgroundImage.encodeUrl()!
        self.latitude = latitude
        self.longitude = longitude
        self.products = products
    }
    
    public static func makeErrorEntity() -> PrintShopDetailEntity {
        PrintShopDetailEntity(id: 0, name: "", address: "", phone: "", email: "", homepage: "",type: "",printType: "",afterProcess: "",businessHours: "" ,introduction: "", logoImage: "", backgroundImage: "", latitude: "", longitude: "",products: [])
    }
}
