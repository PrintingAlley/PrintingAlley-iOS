//
//  BaseAPI.swift
//  Netwrok
//
//  Created by yongbeomkwak on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Moya
import JwtStoreInterface

public protocol AlleyAPI: TargetType, JwtAuthorizable {
    
    var domain: AlleyDomain { get }
    var urlPath: String { get }
    var errorMap: [Int: AlleyError] { get }
    
}

public extension AlleyAPI {
    var baseURL: URL {
        URL(string: BASEURL())!
    }
    
    var path: String {
        domain.asURLString + urlPath
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        .successCodes
    }
}

public enum AlleyDomain: String {
    
    case tmp // TODO: 나중에 도메인 추가
    
}

extension AlleyDomain {
    
    var asDomainString: String {
        switch self {
            
        case .tmp: // TODO: 나중에 도메인 추가 
            return "tmp"
        }
    }
    
    var asURLString: String {
        "/\(self.asDomainString)"
    }
}
