//
//  BookMarkDetailResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

public struct BookMarkDetailResponseDTO: Decodable {
    let id:Int
    
    let printShop: SimplePrintShopResponseDTO
    
    let statusCode: Int?
    let message: String?
 
    public func toDomain() -> BookMarkDetailEntity {
        BookMarkDetailEntity(id: id, printShop: SimplePrintShopInfoEntity(id: self.printShop.id, name: self.printShop.name, address: self.printShop.address, tags: self.printShop.tags.map{$0.toDomain()}), statusCode: statusCode ?? 0, message: message ?? "")
    }
}
