//
//  ContentGroupEntity.swift
//  ContentDomainInterface
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct ContentGroupEntity {
    let contents: [ContentEntity]
    let statusCode: Int
    let message: String
    
    public init(contents: [ContentEntity], statusCode: Int, message: String) {
        self.contents = contents
        self.statusCode = statusCode
        self.message = message
    }
    
}
