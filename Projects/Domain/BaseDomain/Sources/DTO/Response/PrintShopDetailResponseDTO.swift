//
//  PrintShopDetailResponseDTO.swift
//  BaseDomain
//
//  Created by 박의서 on 2023/11/15.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

// MARK: - PrintShop
public struct PrintShopDetailResponseDTO: Decodable {
    let printShop: PrintShopOneResponseDTO
    
    public func toDomain() -> PrintShopEntity {
        PrintShopEntity(id: printShop.id, name: printShop.name, address: printShop.address, phone: printShop.phone, email: printShop.email, homepage: printShop.homepage, type: printShop.type, printType: printShop.printType ?? "", afterProcess: printShop.afterProcess ?? "", afterProcessBinding: printShop.afterProcessBinding ?? "", businessHours: printShop.businessHours, introduction: printShop.introduction, logoImage: printShop.logoImage, backgroundImage: printShop.backgroundImage, latitude: printShop.latitude, longitude: printShop.longitude, products: printShop.products?.map{$0.toDomain()} ?? [])
    }
}

public struct PrintShopOneResponseDTO: Decodable {
    let id: Int
    let name, address, phone, email: String
    let homepage: String
    let type, businessHours, introduction: String
    let latitude, longitude: String
    let products: [ProductResponseDTO]?
    let printType, afterProcess, afterProcessBinding: String?
    let createdAt, updateAt: String
    let ownerId: Int
    let tags: [CategoryResponseDTO]?
    let reviews: [ReviewResponseDTO]?
}
