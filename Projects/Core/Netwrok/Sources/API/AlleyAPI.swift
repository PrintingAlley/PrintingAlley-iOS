//
//  BaseAPI.swift
//  Netwrok
//
//  Created by yongbeomkwak on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import Moya
import JwtStoreInterface

public protocol AlleyAPI: TargetType, JwtAuthorizable {
    
    var domain: AlleyDomain { get }
    var urlPath: String { get }
    var errorMap: [Int: AlleyError] { get }
    
}

public extension AlleyAPI {
    var baseURL: URL {
        URL(string: "BASE")! // TODO: BASE URL로 교체
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
    
    case tmp
    
}

extension AlleyDomain {
    
    var asDomainString: String {
        switch self {
            
        case .tmp:
            return "tmp"
        }
    }
    
    var asURLString: String {
        "/\(self.asDomainString)"
    }
}
