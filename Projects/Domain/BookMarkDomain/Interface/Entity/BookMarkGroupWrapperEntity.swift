//
//  BookMarkGroupWrapperEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 11/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct BookMarkGroupWrapperEntity {
    
    public let bookmarkGroup: BookMarkGroupEntity
    public let statusCode: Int
    public let message: String
    
    public init(bookmarkGroup: BookMarkGroupEntity, statusCode: Int, message: String) {
        self.bookmarkGroup = bookmarkGroup
        self.statusCode = statusCode
        self.message = message
    }
}


