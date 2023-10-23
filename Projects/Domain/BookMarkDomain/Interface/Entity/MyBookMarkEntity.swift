//
//  MyBookMarkEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct MyBookMarkEntity {
    public let id: Int
    public let name: String
    public let count: Int
    public var isSelected: Bool = false
    public let statusCode: Int
    public let message: String
    
    public init(id: Int, name: String, count: Int, statusCode: Int, message: String) {
        self.id = id
        self.name = name
        self.count = count
        self.statusCode = statusCode
        self.message = message
    }
    

}
