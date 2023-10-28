//
//  PrintShopListResponseDto.swift
//  SearchDomain
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

 struct PrintShopListResponseDto: Decodable {
     public let id: Int
     public let name, address, phone, email: String
     public let homepage: String
     public let representative, introduction: String
     public let logoImage, backgroundImage: String
     public let latitude, longitude: String
     public let tags: [String]

     public func toDomain() -> PrintShopEntity {
         PrintShopEntity(id: self.id, name: self.name, address: self.address, phone: self.phone, email: self.email, homepage: self.homepage, representative: self.representative, introduction: self.introduction, logoImage: self.logoImage, backgroundImage: self.backgroundImage, latitude: self.latitude, longitude: self.longitude, tags: self.tags)
     }
 }
