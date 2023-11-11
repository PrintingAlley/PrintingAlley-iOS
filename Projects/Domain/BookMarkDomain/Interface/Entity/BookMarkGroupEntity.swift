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
    public let statusCode: Int
    public let message: String
    
    public init(id: Int, name: String, bookmarks: [BookMarkEntity], statusCode: Int, message: String) {
        self.id = id
        self.name = name
        self.bookmarks = bookmarks
        self.statusCode = statusCode
        self.message = message
    }
    

}
