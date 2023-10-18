//
//  AuthAPI.swift
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
import BookMarkDomain

enum BookMarkAPI {
    case myBookMark
    case addBookMark(printShopId: Int, bookmarkGroupId: Int)
    case removeBookMark(id: Int)
    case linkBookMark(bookMarkId: Int, groupId: Int)
    case generateBookMark(name: String)
    case removeBookMarkGroup(id: Int)
}

extension BookMarkAPI: AlleyAPI {
    var domain: AlleyDomain {
        .bookmark
    }
    
    var urlPath: String {
        
        switch self {
            
        case .myBookMark:
            return "/my-bookmarks"
        case .addBookMark:
            return ""
        case .removeBookMark:
            return ""
        case .linkBookMark:
            return "/group"
        case .generateBookMark:
            return "/group"
        case .removeBookMarkGroup:
            return "/group"
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
 
        case .myBookMark:
            return .get
        case .addBookMark:
            return .post
        case .removeBookMark:
            return .delete
        case .linkBookMark:
            return .put
        case .generateBookMark:
            return .post
        case .removeBookMarkGroup:
            return .delete
        }
    
        var task: Task {
            switch self {
                
            case .myBookMark:
                return .requestPlain
            case .addBookMark(printShopId: let printShopId, bookmarkGroupId: let bookmarkGroupId):
                return .requestJSONEncodable(AddBookMarkRequestDTO(printShopId: printShopId , bookmarkGroupId: bookmarkGroupId))
            case .removeBookMark(id: let id):
                return .requestParameters(parameters: ["id": String(id)], encoding: URLEncoding.queryString)
            case .linkBookMark(bookMarkId: let bookMarkId, groupId: let groupId):
                return .requestParameters(parameters: ["bookmarkId": String(bookMarkId) , "groupId" : String(groupId)], encoding: URLEncoding.queryString)
            case .generateBookMark(name: let name):
                return .requestJSONEncodable(GenerateBookMarkGroupRequestDTO(name: name))
            case .removeBookMarkGroup(id: let id):
                return .requestParameters(parameters: ["id": String(id)], encoding: URLEncoding.queryString)
            }
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        default:
            return .accessToken
        }
    }
    
}
