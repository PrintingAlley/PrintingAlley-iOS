//
//  BookMarkListEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct BookMarkGroupsEntity {
   public let bookmarkGroups: [MyBookMarkEntity]
   public let statusCode: Int
   public let message: String
    
    public init(bookmarkGroups: [MyBookMarkEntity], statusCode: Int, message: String) {
        self.bookmarkGroups = bookmarkGroups
        self.statusCode = statusCode
        self.message = message
    }
    
    public static func makeErrorEntity() -> Self {
        BookMarkGroupsEntity(bookmarkGroups: [], statusCode: 0, message: "")
    }
    
}
