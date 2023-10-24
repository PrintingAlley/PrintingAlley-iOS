//
//  PrintShopListResponseDto.swift
//  SearchDomain
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SearchDomainInterface

 struct PrintShopListResponseDto: Decodable {
     let id: Int
     let image: String?
     let name: String
     let tags: [String]
     let introduction: String
     let address: String

     func toDomain() -> PrintShopListEntity {
         PrintShopListEntity(id: self.id, image: self.image ?? "", name: self.name, tags: self.tags, introduction: self.introduction, address: self.address)
     }
 }
