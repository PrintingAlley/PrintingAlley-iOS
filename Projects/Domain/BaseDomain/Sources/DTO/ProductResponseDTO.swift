//
//  ProductResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface


public struct ProductResponseDTO: Decodable {

    let id: Int
    let name, priceInfo, introduction, description: String
    let mainImage: String
    let images: [String]
    let category: CategoryResponseDTO
    let printShop: PrintShopResponseDTO
    let tagss: [ChildrenTagResponseDTO]
    let reviews: [ReviewResponseDTO]
    
    let statusCode: Int?
    let message: String?
    
    func toDomain() -> ProductEntity {
        ProductEntity(id: id, name: name, priceInfo: priceInfo, introduction: introduction, description: description, mainImage: mainImage, images: images, category: category.toDomain(), printShop: printShop.toDomain(), tagss: tagss.map{$0.toDomain()}, reviews: reviews.map{$0.toDomain()}, statusCode: statusCode ?? 0, message: message ?? "")
    }
}



