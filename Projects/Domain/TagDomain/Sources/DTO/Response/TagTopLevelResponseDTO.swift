//
//  TagTopLevelResponseDTO.swift
//  TagDomain
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import TagDomainInterface

struct TagTopLevelResponseDTO: Decodable { 
    let id: Int
    let name: String
    let image: String?
    
    func toDomain() -> TagToplevelEntity {
        TagToplevelEntity(id: self.id, name: self.name, image: self.image ?? "")
    }
}
