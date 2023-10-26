//
//  ChildrenTagEntity.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/24/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public struct ChildrenTagEntity {
    public let id: Int
    public let name: String
    public let image: String
    public let parentID: Int
    public let children: [ChildrenTagEntity]
    public var isSelected: Bool = false

    public init(id: Int, name: String, image: String, parentID: Int, children : [ChildrenTagEntity]) {
        self.id = id
        self.name = name
        self.image = image
        self.parentID = parentID
        self.children = children
    }

}
