//
//  AddBookMarkResponseDTO.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 11/5/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

public struct AddBookMarkResponseDTO: Decodable {
    
    let statusCode: Int
    let message: String
    let dataId: Int?
    
    public func toDomain() -> AddBookMarkEntity {
        return AddBookMarkEntity(statusCode: statusCode, message: message, dataId: dataId ?? 0 )
    }
    
}
