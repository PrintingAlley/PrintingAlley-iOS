//
//  AlleyError.swift
//  Network
//
//  Created by yongbeomkwak on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public enum AlleyError: Error, Equatable {
    case unknown
    case badRequest
    case tokenExpired
    case forbidden
    case notFound
    case conflict
    case tooManyRequest
    case internalServerError
    case offline
    
    public init(statusCode: Int) {
        
        switch statusCode {
        case 400:
            self = .badRequest
            
        case 401:
            self = .tokenExpired

        case 403:
            self = .forbidden

        case 404:
            self = .notFound

        case 409:
            self = .conflict

        case 429:
            self = .tooManyRequest

        case 500:
            self = .internalServerError
            
        case 1009:
            self = .offline

        default:
            self = .internalServerError
        }
        
    }

}

extension AlleyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "알 수 없는 오류가 발생하였습니다."
        case .badRequest: // 400
            return "요청이 잘못되었습니다."
        case .tokenExpired: // 401
            return "인증이 만료되었습니다.\n다시 로그인해 주세요."
        case .forbidden: // 403
            return "접근 권한이 없습니다."
        case .notFound: // 404
            return "요청한 것을 찾을 수 없습니다."
        case .conflict: // 409
            return "이미 사용 중인 이름이에요!"
        case .tooManyRequest: // 429
            return "요청 횟수를 초과했습니다.\n잠시 후 다시 시도해주세요!"
        case .internalServerError: // 500
            return "서버에서 문제가 발생하였습니다.\n잠시 후 다시 시도해주세요!"
        
        case .offline:
            return "인터넷 연결이 오프라인입니다.\n네트워크 상태를 확인해주세요."
        }
    }
}

public extension Error {
    var asAlleyError: AlleyError {
    
        self as? AlleyError ?? .unknown
    }
    
    var tempAlleyError: AlleyError {
        
        let s = self.localizedDescription
        
        if s.contains("400") {
            return  .badRequest
        } else if s.contains("401") {
            
            return .tokenExpired
            
        } else if s.contains("404") {
            
            return .notFound
            
        } else if s.contains("409") {
            
            return .conflict
            
        } else if s.contains("429") {
            
            return .tooManyRequest
            
        } else if s.contains("500") {
            
            return .internalServerError
            
        } else if s.contains("1009") {
            return .offline
            
        } else {
            return .internalServerError
        }
            
        
    }
}
