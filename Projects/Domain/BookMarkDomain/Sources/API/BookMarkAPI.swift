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
    case removeBookMarkGroup(ids: [Int])
    case fetchBookMarkDetail(id: Int)
}

extension BookMarkAPI: AlleyAPI {
    var domain: AlleyDomain {
        .bookmark
    }
    
    var urlPath: String {
        
        switch self {
            
        case .myBookMark:
            return "/my-bookmarks"
            
        case .fetchBookMarkDetail(id: let id):
            return "/group/\(id)"
            
        case .addBookMark:
            return ""
            
        case .removeBookMark(id: let id):
            return "/\(id)"
            
        case .linkBookMark(bookMarkId: let bookMarkId, groupId: let groupId):
            return "/group/\(bookMarkId)/\(groupId)"
            
        case .generateBookMark:
            return "/group"
            
        case .removeBookMarkGroup:
            return "/groups"
            
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
         
        case .fetchBookMarkDetail:
            return .get
        }
    }
    
        var task: Task {
            switch self {
                
            case .myBookMark:
                return .requestPlain
            case .addBookMark(printShopId: let printShopId, bookmarkGroupId: let bookmarkGroupId):
                return .requestJSONEncodable(AddBookMarkRequestDTO(printShopId: printShopId , bookmarkGroupId: bookmarkGroupId))
                
            case .removeBookMark:
                return .requestPlain
                
            case .linkBookMark:
                return .requestPlain
                
            case .generateBookMark(name: let name):
                return .requestJSONEncodable(GenerateBookMarkGroupRequestDTO(name: name))
                
            case .removeBookMarkGroup(ids: let ids):
                return .requestJSONEncodable(RemoveBookMarkGroupRequestDTO(groupIds: ids))
                
            case .fetchBookMarkDetail:
                return .requestPlain
            }
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        default:
            return .accessToken
        }
    }
    
}
