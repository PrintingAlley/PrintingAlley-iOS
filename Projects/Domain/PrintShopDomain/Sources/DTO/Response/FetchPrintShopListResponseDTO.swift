//
//  FetchPrintShopsResponseDTO.swift
//  PrintShopDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import PrintShopDomainInterface
import BaseDomain

struct FetchPrintShopListResponseDTO: Decodable {
    let printShops: [PrintShopResponseDTO]
    let totalCount: Int
    let statusCode: Int?
    let message: String?
    
    public func toDomain() -> PrintShopListEntity {
        PrintShopListEntity(printShops: printShops.map{$0.toDomain()}, totalCount: totalCount, statusCode: statusCode ?? 0 , message: message ?? "")
    }
}
