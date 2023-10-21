//
//  FetchUserInfoResponseDTO.swift
//  UserDomain
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UserDomainInterface

struct FetchUserInfoResponseDTO: Decodable {
    let id: Int
    let provider: String
    let name: String
    let profileImage: String?
    let email: String?
    
    let statusCode: Int?
    let message: String?
    
    
    func toDomain() -> UserInfoEntity {
        UserInfoEntity(id: self.id, provider: self.provider, name: self.name, profileImage: self.profileImage ?? "", email: self.email ?? "" ,statusCode: statusCode ?? 0, message: message ?? "")
    }
}
