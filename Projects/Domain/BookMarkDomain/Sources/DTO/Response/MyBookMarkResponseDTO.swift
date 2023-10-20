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
    let bookmarks: [BookmarkDTO]
    let statusCode: Int?
    let message: String?
    
    func toDomain() -> MyBookMarkEntity {
        MyBookMarkEntity(id: self.id, name: self.name, bookmarks: self.bookmarks.map{$0.id}, statusCode: self.statusCode ?? 0, message: self.message ?? "")
        
    }
    
}

public struct BookmarkDTO: Decodable {
    let id: Int

}
