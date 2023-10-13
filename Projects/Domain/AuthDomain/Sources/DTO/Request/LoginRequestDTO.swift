//
//  LoginRequestDTO.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

struct LoginRequestDTO: Encodable {
    let access_token: String
    let provider: String
}
