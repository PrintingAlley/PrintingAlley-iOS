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
    
    func toDomain() -> MyBookMarkEntity {
        MyBookMarkEntity(id:self.id,name: self.name, bookmarks: self.bookmarks.map{$0.id})
    }
    
}

public struct BookmarkDTO: Decodable {
    let id: Int

}
