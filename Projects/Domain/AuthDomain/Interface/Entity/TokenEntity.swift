//
//  TestEntity.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct TokenEntity {
    public let access_token: String
    public let statusCode: Int
    public let message: String
    
    public init(access_token: String, statusCode: Int, message: String) {
        self.access_token = access_token
        self.statusCode = statusCode
        self.message = message
    }
    
}
