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

enum PrintShopAPI {
    case list(page: Int, searchText: String)
    case one(id: Int)
    case fetchReview(id: Int)
    case createReview(id: Int, content: String, rating: Int, images: [String])
    case editReview(id: Int, reviewId: Int, content: String, rating: Int, images: [String])
    case deleteReview(id: Int, reviewId: Int)
    
}

extension PrintShopAPI: AlleyAPI {
    var domain: AlleyDomain {
        .printShop
    }
    
    var urlPath: String {
        
        switch self {
          
        case .list:
            return ""
            
        case .one(id: let id):
            return "/\(id)"
        case .fetchReview(id: let id):
            return "/\(id)/review"
        case .createReview(id: let id, content: _, rating: _, images: _):
            return "/\(id)/review"
        case .editReview(id: let id, reviewId: let reviewId, content: _, rating: _, images: _):
            return "/\(id)/review/\(reviewId)"
        case .deleteReview(id: let id, reviewId: let reviewId):
            return "/\(id)/review/\(reviewId)"
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
         
        case .list, .one, .fetchReview:
            return .get
        
        case .createReview:
            return .post
        
        case .editReview:
            return .put
        
        case .deleteReview:
            return .delete
        }
    }
    
        var task: Task {
            switch self {
              
            case .list(let page, let searchText):
                return .requestParameters(parameters: ["page": page,"searchText": searchText], encoding: URLEncoding.queryString)
            
            case .one, .fetchReview, .deleteReview:
                return .requestPlain
                
                
            case .createReview(id: let id, content: let content, rating: let rating, images: let images):
                return .requestJSONEncodable(ReviewRequestDTO(content: content, rating: rating, images: images))
            case .editReview(id: let id, reviewId: let reviewId, content: let content, rating: let rating, images: let images):
                return .requestJSONEncodable(ReviewRequestDTO(content: content, rating: rating, images: images))
            }
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        case .list, .one, .fetchReview:
            return .none

        case .createReview, .editReview, .deleteReview:
            return .accessToken
        }
    }
    
}
