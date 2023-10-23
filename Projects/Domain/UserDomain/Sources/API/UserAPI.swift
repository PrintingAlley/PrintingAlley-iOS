//
//  UserAPI.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import Network
import Moya
import JwtStoreInterface


enum UserAPI {
    case fetchUserInfo
    case renameUser(name: String)
}

extension UserAPI: AlleyAPI {
    var domain: AlleyDomain {
        .user
    }
    
    var urlPath: String {
        
        switch self {
        case .fetchUserInfo:
            return ""
        case .renameUser:
            return "/name"
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

        case .fetchUserInfo:
            return .get
        case .renameUser:
            return .put
        }
    }
    
        var task: Task {
            switch self {
                
                    
            case .fetchUserInfo:
                return .requestPlain
            case .renameUser(name: let name):
                return .requestJSONEncodable(RenameRequestDTO(name: name))
            }
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        default:
            return .accessToken
        }
    }
    
}
