//
//  File.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface
import BaseDomain
import BaseDomainInterface

public struct BookMarkGroupResponseDTO: Decodable {
    let id: Int
    let name: String
    let bookmarks: [BookMarkResponseDTO]
    
    
    
    func toDomain() -> BookMarkGroupEntity {
       BookMarkGroupEntity(id: id, name: name, bookmarks: [])
    }

}
