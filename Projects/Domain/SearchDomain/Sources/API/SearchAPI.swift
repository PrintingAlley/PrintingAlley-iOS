//
//  SearchAPI.swift
//  SearchDomain
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import Network
import Moya
import JwtStoreInterface

enum SearchAPI {
    case list(searchText: String, tagIds: [Int])
}

extension SearchAPI: AlleyAPI {
    var domain: AlleyDomain {
        .printShop
    }
    
    var urlPath: String {
        
        switch self {
          
        case .list:
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
                500: .internalServerError,
                1009: .offline
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
         
        case .list:
            return .get
        }
    }
    
        var task: Task {
            switch self {
              
            case .list(let searchText, let tagIds):
                return .requestParameters(parameters: ["searchText": searchText, "tagIds": tagIds], encoding: URLEncoding.queryString)
            }
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        case .list:
            return .none
        }
    }
    
}
