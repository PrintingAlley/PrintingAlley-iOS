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
    public let recentImage: String
    
    public init(id: Int, name: String, count: Int, recentImage: String) {
        self.id = id
        self.name = name
        self.count = count
        self.recentImage = recentImage
    }

    

}
