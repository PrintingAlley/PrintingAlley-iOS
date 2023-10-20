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
    
    init(id: Int, name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
    
    public func toDomain() -> SimplePrintShopInfoEntity {
        SimplePrintShopInfoEntity(id: self.id, name: self.name, address: self.address)
    }
}
