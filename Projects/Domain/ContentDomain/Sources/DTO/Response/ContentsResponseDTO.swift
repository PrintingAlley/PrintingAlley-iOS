//
//  ContentsResponseDTO.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ContentDomainInterface

struct ContentsResponseDTO: Decodable {
    let contents: [ContentResponseDTO]
    let statusCode: Int?
    let message: String?

    func toDomain() -> ContentGroupEntity {
        ContentGroupEntity(contents: contents.map{$0.toDomain()}, statusCode: statusCode ?? 0, message: message ?? "")
    }
}
