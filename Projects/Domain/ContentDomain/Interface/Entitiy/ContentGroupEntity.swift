//
//  ContentGroupEntity.swift
//  ContentDomainInterface
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct ContentGroupEntity {
   public let contents: [ContentEntity]
   public  let statusCode: Int
   public  let message: String
    
    public init(contents: [ContentEntity], statusCode: Int, message: String) {
        self.contents = contents
        self.statusCode = statusCode
        self.message = message
    }
    
}
