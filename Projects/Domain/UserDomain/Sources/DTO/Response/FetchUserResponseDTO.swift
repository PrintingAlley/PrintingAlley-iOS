//
//  UserResponseDTO.swift
//  UserDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import BaseDomainInterface

public struct FetchUserResponseDTO: Decodable {
    
    let user: UserResponseDTO
    
    let statusCode: Int?
    let message: String?
    
    
    public func toDomain() -> UserInfoEntity {
        user.toDomain()
    }
}
