//
//  ContentEntity.swift
//  ContentDomainInterface
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct ContentEntity {
    public let id: Int
    public let title,thumbnail: String
    
    public init(id: Int, title: String, thumbnail: String) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
    
    static func makeErrorEntity() -> Self {
        ContentEntity(id: 0, title: "", thumbnail: "")
    }
}
