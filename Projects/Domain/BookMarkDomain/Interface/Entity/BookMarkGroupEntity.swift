//
//  BookMarkGroupEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct BookMarkGroupEntity {
    public let id: Int
    public let name: String
    public let bookmarks: [BookMarkEntity]

    
    public init(id: Int, name: String, bookmarks: [BookMarkEntity]) {
        self.id = id
        self.name = name
        self.bookmarks = bookmarks

    }
    

}
