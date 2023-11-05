//
//  VersionCheckEntity.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 11/5/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct VersionCheckEntity {
    let code: Int // 0 : 통과 , 1: 업데이트 권고 , 2: 강제 업데이트
    let statusCode: Int
    let message: String
    
    
    public init(code: Int, statusCode: Int, message: String) {
        self.code = code
        self.statusCode = statusCode
        self.message = message
    }
}
