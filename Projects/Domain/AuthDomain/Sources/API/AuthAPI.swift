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
    case verify
    case logout
    case withdraw
    case versionCheck(version: String)
}

extension AuthAPI: AlleyAPI {
    var domain: AlleyDomain {
        .auth
    }
    
    var urlPath: String {
        
        switch self {
            
        case .login:
            return "/login"
        case .verify:
            return "/verify"
        case .logout:
            return "/logout"
        case .withdraw:
            return "/withdrawal"
        case .versionCheck(version: let version):
            return "/api-version/v\(version)"
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
                500: .internalServerError,
                1009: .offline
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .verify:
            return .get
        
        case .logout:
            return .post
            
        case .withdraw:
            return .delete
        case .versionCheck:
            return .get
        }
    
    }
    
    var task: Task {
        switch self {
            
        case .login(token: let token, provider: let provider):
            return .requestJSONEncodable(LoginRequestDTO(access_token: token, provider: provider))
            
        case .verify:
            return .requestPlain
        
        case .logout,.withdraw:
            return .requestPlain
        case .versionCheck:
            return .requestPlain
        }
    }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        case .login,.versionCheck:
            return .none
        case .verify, .logout, .withdraw:
            return .accessToken
        }
    }
    
}
