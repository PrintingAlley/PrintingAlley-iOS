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
    let name, size, paper, afterProcess,designer, introduction, description: String
    let mainImage: String
    let images: [String]
    let category: CategoryResponseDTO?
    let printShop: PrintShopResponseDTO?
    let tags: [ChildrenTagResponseDTO]?
    let reviews: [ReviewResponseDTO]?
    let isBookmarked: Bool?
    let statusCode: Int?
    let message: String?
    
    public func toDomain() -> ProductEntity {
        ProductEntity(id: id, name: name, size: "" ,  paper: "", afterProcess: "", designer: "" , introduction: introduction, description: description, mainImage: mainImage, images: images,
                      category: category?.toDomain() ?? CategoryEntity.makeErrorEntity(),
                      printShop: printShop?.toDomain() ?? PrintShopEntity.makeErrorEntity(),
                      tags: tags?.map{$0.toDomain()} ?? [],
                      reviews: reviews?.map{$0.toDomain()} ?? [], isBookmarked: isBookmarked ?? false,
                      statusCode: statusCode ?? 0, message: message ?? "")
    }
}



