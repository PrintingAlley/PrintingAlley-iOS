//
//  TestEntity.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct TokenEntity {
    let access_token: String
    
    public init(access_token: String) {
        self.access_token = access_token
    }
    
}
