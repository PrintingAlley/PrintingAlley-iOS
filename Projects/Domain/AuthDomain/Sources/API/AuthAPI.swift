//
//  AuthAPI.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface
import BaseDomain
import Network
import Moya
import JwtStoreInterface

enum AuthAPI {
    case login(token: String, provider : String)
    case jwt
    case logout
    case withdraw
}

extension AuthAPI: AlleyAPI {
    var domain: AlleyDomain {
        .auth
    }
    
    var urlPath: String {
        
        switch self {
            
        case .login:
            return "/login"
        case .jwt:
            return "/jwt-test"
        case .logout:
            return "/logout"
        case .withdraw:
            return "/withdraw"
        }
    }
    
    var errorMap: [Int: Network.AlleyError] {
        switch self {
        default:
            return [
                400: .badRequest,
                401: .tokenExpired,
                404: .notFound,
                429: .tooManyRequest,
                500: .internalServerError
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .jwt:
            return .get
        
        case .logout:
            return .get
            
        case .withdraw:
            return .delete
        }
    
    }
    
    var task: Task {
        switch self {
            
        case .login(token: let token, provider: let provider):
            return .requestJSONEncodable(LoginRequestDTO(access_token: token, provider: provider))
            
        case .jwt:
            return .requestPlain
        
        case .logout,.withdraw:
            return .requestPlain
        }
    }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        case .login:
            return .none
        case .jwt,.logout,.withdraw:
            return .accessToken
        }
    }
    
}
