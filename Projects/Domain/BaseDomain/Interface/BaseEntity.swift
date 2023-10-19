//
//  interface.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public struct BaseEntity {
    
    public let statusCode: Int
    public let message: String
    
    public init(statusCode: Int, message: String) {
        self.statusCode = statusCode
        self.message = message
    }
    
}
