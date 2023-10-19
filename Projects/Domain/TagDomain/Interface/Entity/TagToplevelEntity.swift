//
//  TagToplevelEntity.swift
//  TagDomainInterface
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct TagToplevelEntity { // Decodable no
    public let id: Int
    public let name: String
    public let image: String
    
    // init 생성
    
    public init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}

// DTO와 Entity를 나눈 이유: 클라 상에서 필요한 변수는 Entity에 담아두기
