//
//  TokenTestEntity.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct VerifyEntity {
    public let isValid: Bool
    public let statusCode: Int
    public let message: String
    
    public init(isValid: Bool, statusCode: Int, message: String) {
        self.isValid = isValid
        self.statusCode = statusCode
        self.message = message
    }
}
