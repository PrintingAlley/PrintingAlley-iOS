//
//  VersionCheckResponseDTO.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 11/5/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface

struct VersionCheckResponseDTO: Decodable {
    let code: Int
    let statusCode: Int?
    let message: String?
    

    
    func toDomain() -> VersionCheckEntity {
        VersionCheckEntity(code: code, statusCode: statusCode ?? 0, message: message ?? "")
    }
}
