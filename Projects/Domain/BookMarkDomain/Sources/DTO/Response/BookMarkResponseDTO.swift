//
//  BookMarksResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


import Foundation
import BookMarkDomainInterface

public struct BookMarkResponseDTO: Decodable {
    let id: Int
    let printShop: SimplePrintShopResponseDTO
    

 
    public func toDomain() -> BookMarkEntity {
        BookMarkEntity(id:self.id ,printShop: self.printShop.toDomain())
    }
}
