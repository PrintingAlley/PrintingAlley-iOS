//
//  ContentResponseDTO.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ContentDomainInterface

struct ContentResponseDTO: Decodable {
    let id: Int
    let title: String
    let thumbnail: String
    let webViewUrl: String
    
    
    func toDomain() -> ContentEntity {
        ContentEntity(id: id, title: title, thumbnail: thumbnail, webViewUrl: webViewUrl)
    }
}
