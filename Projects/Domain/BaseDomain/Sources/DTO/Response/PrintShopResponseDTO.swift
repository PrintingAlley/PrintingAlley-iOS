//
//  PrintShopResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/23/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

// MARK: - PrintShop
public struct PrintShopResponseDTO: Decodable {
    let id: Int
    let name, address, phone, email: String
    let homepage: String
    let type, businessHours, introduction: String
    let latitude, longitude: String
    let products: [ProductResponseDTO]?
    let printType, afterProcess, backgroundImage, logoImage: String?
    
    public func toDomain() -> PrintShopEntity {
        PrintShopEntity(id: id, name: name, address: address, phone: phone, email: email, homepage: homepage, type: type, printType: printType ?? "", afterProcess: afterProcess ?? "", businessHours: businessHours  , introduction: introduction, logoImage: logoImage ?? "", backgroundImage: backgroundImage ?? "" , latitude: latitude, longitude: longitude,products: products?.map{$0.toDomain()} ?? [])
    }
}
