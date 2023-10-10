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
    case testGet
}

extension AuthAPI: AlleyAPI {
    var domain: AlleyDomain {
        .tmp
    }
    
    var urlPath: String {
        
        switch self {
            
        case .testGet:
            return ""
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
        case .testGet:
            return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .testGet:
            return .requestPlain
        }
    }
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        case .testGet:
            return .none
        }
    }
    
}
