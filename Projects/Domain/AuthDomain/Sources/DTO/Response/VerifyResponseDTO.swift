//
//  TestDTO.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface

struct VerifyResponseDTO: Decodable {
    let isValid: Bool
    let statusCode: Int?
    let message: String?
    

    
    func toDomain() -> VerifyEntity {
        VerifyEntity(isValid: isValid, statusCode: self.statusCode ?? 0, message: self.message ?? "")
    }
}


