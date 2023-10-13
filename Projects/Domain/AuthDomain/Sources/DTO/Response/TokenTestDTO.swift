//
//  TestDTO.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface

struct TokenTestDTO: Decodable {
    let socialID, provider, name, email: String
    let createdAt, updateAt: String
    
    enum CodingKeys: String, CodingKey {
        case socialID = "socialId"
        case provider, name, email, createdAt, updateAt
    }
    
    public func toDomain() -> TokenTestEntity {
       TokenTestEntity(socialID: socialID, provider: provider, name: name, email: email, createdAt: createdAt, updateAt: updateAt)
    }
}


