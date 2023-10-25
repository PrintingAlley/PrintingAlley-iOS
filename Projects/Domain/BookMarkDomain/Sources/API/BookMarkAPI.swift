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


enum BookMarkAPI {
    case myBookMark
    case addBookMark(printShopId: Int, groupId: Int)
    case removeBookMark(id: Int)
    case linkBookMark(bookMarkId: Int, groupId: Int)
    case generateBookMark(name: String)
    case removeBookMarkGroup(ids: [Int])
    case fetchBookMarkDetail(id: Int)
    case renameBookMarkGroup(id: Int, name: String)
}

extension BookMarkAPI: AlleyAPI {
    var domain: AlleyDomain {
        .bookmark
    }
    
    var urlPath: String {
        
        switch self {
            
        case .myBookMark:
            return "/group"
            
        case .fetchBookMarkDetail(id: let id):
            return "/group/\(id)"
            
        case .addBookMark:
            return ""
            
        case .removeBookMark(id: let id):
            return "/\(id)"
            
        case .linkBookMark(bookMarkId: let bookMarkId, groupId: _):
            return "/group/\(bookMarkId)"
            
        case .generateBookMark:
            return "/group"
            
        case .removeBookMarkGroup:
            return "/groups"
            

        case .renameBookMarkGroup(id: let id, name: let name):
            return "/group/\(id)"
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
        case .renameBookMarkGroup:
            return .put
        }
    }
    
        var task: Task {
            switch self {
                
            case .myBookMark:
                return .requestPlain
            case .addBookMark(printShopId: let printShopId, groupId: let groupId):
                return .requestJSONEncodable(AddBookMarkRequestDTO(printShopId: printShopId , groupId: groupId))
                
            case .removeBookMark:
                return .requestPlain
                
            case .linkBookMark(bookMarkId: _, groupId: let groupId):
                return .requestJSONEncodable(LinkBookMarkRequestDTO(groupId: groupId))
                
            case .generateBookMark(name: let name):
                return .requestJSONEncodable(GenerateBookMarkGroupRequestDTO(name: name))
                
            case .removeBookMarkGroup(ids: let ids):
                return .requestJSONEncodable(RemoveBookMarkGroupRequestDTO(groupIds: ids))
                
            case .fetchBookMarkDetail:
                return .requestPlain
            case .renameBookMarkGroup(id: _, name: let name):
                return .requestJSONEncodable(RenameBookMarkGroupRequestDTO(name: name))
            }
        }
    
    
    var jwtStoreProperties: JwtStoreProperties {
        switch self {
        default:
            return .accessToken
        }
    }
    
}
