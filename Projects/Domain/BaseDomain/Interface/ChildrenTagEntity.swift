//
//  ChildrenTagEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/24/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule

public struct ChildrenTagEntity {
    public let id: Int
    public let name: String
    public let image: String
    public let parentID: Int
    public let children: [ChildrenTagEntity]
    public var isSelected: Bool = false

    public init(id: Int, name: String, image: String, parentID: Int, children: [ChildrenTagEntity]) {
        self.id = id
        self.name = name
        self.image = image.encodeUrl()!
        self.parentID = parentID
        self.children = children
    }
    
    public static func makeErrorEntity() -> Self  {
        ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: [])
    }

    public static func makeDummy() -> [Self] {[
        ChildrenTagEntity(id: 0, name: "소량인쇄", image: "", parentID: 0, children: []),
        ChildrenTagEntity(id: 0, name: "인쇄상담", image: "", parentID: 0, children: []),
        ChildrenTagEntity(id: 0, name: "당일인쇄", image: "", parentID: 0, children: []),
        ChildrenTagEntity(id: 0, name: "24시수령", image: "", parentID: 0, children: []),
        ChildrenTagEntity(id: 0, name: "대형인쇄", image: "", parentID: 0, children: [])
    ]}
}
