//
//  BaseResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct BaseResponseDTO: Decodable {
    
    let statusCode: Int
    let message: String
    
    public func toDomain() -> BaseEntity {
        return BaseEntity(statusCode: self.statusCode, message: self.message)
    }
    
}
