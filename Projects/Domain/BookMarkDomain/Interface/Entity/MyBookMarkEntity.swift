//
//  MyBookMarkEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct MyBookMarkEntity {
    let id: Int
    let name: String
    let bookmarks: [Int]
    
    public init(id: Int, name: String, bookmarks: [Int]) {
        self.id = id
        self.name = name
        self.bookmarks = bookmarks
    }
}
