//
//  SimpleBookMarkResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

public struct SimplePrintShopResponseDTO: Decodable {
    public let id: Int
    public let name: String
    public let address: String
    public let tags: [SimpleTagDTO]
    let statusCode: Int?
    let message: String?
    

    public func toDomain() -> SimplePrintShopInfoEntity {
        
        SimplePrintShopInfoEntity(id: self.id, name: self.name, address: self.address, tags: tags.map{SimpleTagEntity(id: $0.id, name: $0.name)}, statusCode: self.statusCode ?? 0, message: self.message ?? "")
    }
}

public struct SimpleTagDTO: Decodable {
    public let id: Int
    public let name: String
    
    public func toDomain() -> SimpleTagEntity {
        SimpleTagEntity(id: self.id, name: self.name)
    }
}
