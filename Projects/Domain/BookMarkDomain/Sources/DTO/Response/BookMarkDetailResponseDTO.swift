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
    let id: Int
    let name: String
    let bookmarks: [BookMarkResponseDTO]
    
    let statusCode: Int?
    let message: String?
 
    public func toDomain() -> BookMarkDetailEntity {
        BookMarkDetailEntity(id: self.id, name: self.name, bookmarks: self.bookmarks.map{$0.toDomain()}, statusCode: statusCode ?? 0, message: message ?? "")
    }
}
