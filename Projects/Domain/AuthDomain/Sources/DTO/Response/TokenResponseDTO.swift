//
//  TestDTO.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface

struct TokenResponseDTO: Decodable {
    let access_token: String
    
    public func toDomain() -> TokenEntity {
        return TokenEntity(access_token: self.access_token)
    }
}


