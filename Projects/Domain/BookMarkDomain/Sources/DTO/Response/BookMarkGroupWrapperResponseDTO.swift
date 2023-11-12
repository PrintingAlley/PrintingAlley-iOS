//
//  BookMarkGroupWrapperResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 11/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

public struct BookMarkGroupWrapperResponseDTO: Decodable {
    
    public let bookmarkGroup: BookMarkGroupResponseDTO
    public let statusCode: Int?
    public let message: String?
    

    func toDomain() -> BookMarkGroupWrapperEntity {
        BookMarkGroupWrapperEntity(bookmarkGroup: bookmarkGroup.toDomain(), statusCode: statusCode ?? 0, message: message ?? "")
    }
}
