//
//  SearchAPI.swift
//  SearchDomain
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Network
import Moya
import JwtStoreInterface
import BaseDomain

enum ProductAPI {
    case fetchProduct(id: Int)
    case fetchProductList(page:Int, text: String, tagIds: [Int])
    case createReview(id: Int,content: String, rating: Int, images: [String])
    case editReview(id: Int, reviewId: Int, content: String, rating: Int, images: [String])
    case deleteReview(id: Int, reviewId: Int)
    case fetchReview(id: Int)
}

extension ProductAPI: AlleyAPI {
    var domain: AlleyDomain {
        .product
    }
    
    var urlPath: String {
        switch self {
            
        case .fetchProduct(id: let id):
            return "/\(id)"
        case .fetchProductList:
            return ""
        case .createReview(id: let id, content: _, rating: _, images: _):
            return "/\(id)/review"
        
        case .editReview(id: let id, reviewId: let reviewId, content: _, rating: _, images: _):
            return "/\(id)/review/\(reviewId)"
            
           
        case .deleteReview(id: let id, reviewId: let reviewId):
            return "/\(id)/review/\(reviewId)"
        
        case .fetchReview(id: let id):
            return "/\(id)/review"
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
         
        
        case .fetchProduct, .fetchProductList,.fetchReview:
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
                
            case .fetchProduct,.fetchReview:
                return .requestPlain
          
            case .createReview(id: let id, content: let content, rating: let rating, images: let images):
                return .requestJSONEncodable(ReviewRequestDTO(content: content, rating: rating, images: images))
            case .editReview(id: let id, reviewId: let reviewId, content: let content, rating: let rating, images: let images):
                return .requestJSONEncodable(ReviewRequestDTO(content: content, rating: rating, images: images))
            case .deleteReview(id: let id, reviewId: let reviewId):
                return .requestPlain
                
            case .fetchProductList(page: let page, text: let text, tagIds: let tagIds):
                
                return .requestParameters(parameters: ["page":page,"searchText":text,"tagIds":tagIds], encoding: URLEncoding.queryString)
            }
            
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
            
    
        case .fetchProductList,.fetchReview:
            return .none
        case .fetchProduct:
            return .accessToken
        case .createReview(id: let id, content: let content, rating: let rating, images: let images):
            return .accessToken
        case .editReview(id: let id, reviewId: let reviewId, content: let content, rating: let rating, images: let images):
            return .accessToken
        case .deleteReview(id: let id, reviewId: let reviewId):
            return .accessToken
        }
    }
    
}
