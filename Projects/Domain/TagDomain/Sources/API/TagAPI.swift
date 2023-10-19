//
//  TagAPI.swift
//  TagDomainInterface
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

 // MOya - Interface 설정 후

import Foundation
import BaseDomain
import Network
import Moya
import JwtStoreInterface
import TagDomain

enum TagAPI {
    case topLevel
}

extension TagAPI: AlleyAPI {
    var domain: AlleyDomain {
        .tag
    }
    
    var urlPath: String {
        
        switch self {
          
        case .topLevel:
            return "/top-level"
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
         
        case .topLevel:
            return .get
        }
    }
    
        var task: Task {
            switch self {
              
            case .topLevel:
                return .requestPlain
            }
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        case .topLevel:
            return .none // token 있을 땐 .aceessToken
        }
    }
    
}

