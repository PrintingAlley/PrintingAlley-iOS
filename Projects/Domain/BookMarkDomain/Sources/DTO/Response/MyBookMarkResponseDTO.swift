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
    let recentImage: String?
    
    func toDomain() -> MyBookMarkEntity {
       MyBookMarkEntity(id: id, name: name, count: bookmarkCount, recentImage: recentImage ?? "")
        
    }
    
}


