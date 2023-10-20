//
//  RenameBookMarkEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct RenameBookMarkEntity  {
    
    public let name: String
    
    public let statusCode: Int
    public let message: String
    
    public init(name: String, statusCode: Int, message: String) {
        self.name = name
        self.statusCode = statusCode
        self.message = message
    }
    
}
