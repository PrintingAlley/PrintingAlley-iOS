//
//  MyBookMarkResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

struct MyBookMarkResponseDTO: Decodable {
    
    let id: Int
    let name: String
    let bookmarkCount: Int
    
    func toDomain() -> MyBookMarkEntity {
        MyBookMarkEntity(id: self.id, name: self.name, count: bookmarkCount)
        
    }
    
}


