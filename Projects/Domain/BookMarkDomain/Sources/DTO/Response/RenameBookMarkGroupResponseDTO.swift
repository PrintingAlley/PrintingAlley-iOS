//
//  RenameBookMarkGroupResponseDTO.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface

struct RenameBookMarkGroupResponseDTO: Decodable {
    
    let name: String?
    let statusCode: Int?
    let message: String?
    
    func toDomain() -> RenameBookMarkEntity {
     
          RenameBookMarkEntity(name: name ?? "", statusCode: statusCode ?? 0, message: message ?? "")
    }
    
}
