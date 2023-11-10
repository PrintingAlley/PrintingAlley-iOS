//
//  ContentAPI.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import Network
import Moya
import JwtStoreInterface


enum ContentAPI {
    case fetchContents
}

extension ContentAPI: AlleyAPI {

    
    var domain: AlleyDomain {
        .content
    }
    
    var urlPath: String {
        
        switch self {
            
        case .fetchContents:
            ""
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
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var method: Moya.Method {
        .get
    }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        default:
            return .none
        }
    }
    
}
