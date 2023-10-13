//
//  TokenTestEntity.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct TokenTestEntity {
    let socialID, provider, name, email: String
    let createdAt, updateAt: String
    
    public init(socialID: String, provider: String, name: String, email: String, createdAt: String, updateAt: String) {
        self.socialID = socialID
        self.provider = provider
        self.name = name
        self.email = email
        self.createdAt = createdAt
        self.updateAt = updateAt
    }
}
