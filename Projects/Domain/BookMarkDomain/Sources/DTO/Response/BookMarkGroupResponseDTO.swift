//
//  BookMarkListResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

struct BookMarkGroupResponseDTO: Decodable {
    let bookmarkGroups: [MyBookMarkResponseDTO]
    let statusCode: Int?
    let message: String?
    
    
    func toDomain() -> BookMarkGroupEntity {
        BookMarkGroupEntity(bookmarkGroups: bookmarkGroups.map{$0.toDomain()}, statusCode: statusCode ?? 0, message: message ?? "")
    }
    
    
}
