//
//  RemoteBookMarkDataSourceImpl.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import BookMarkDomainInterface
import RxSwift
import BaseDomainInterface


final class RemoteBookMarkDataSourceImpl: BaseRemoteDataSource<BookMarkAPI>, RemoteBookMarkDataSource {
   
    
    func renameBookMarkGroup(id: Int, name: String) -> RxSwift.Single<BookMarkDomainInterface.RenameBookMarkEntity> {
        request(.renameBookMarkGroup(id: id, name: name))
            .map(RenameBookMarkGroupResponseDTO.self)
            .map{$0.toDomain()}
    }
    

    
    func fetchMyBookMarks() -> RxSwift.Single<[BookMarkDomainInterface.MyBookMarkEntity]> {
        request(.myBookMark)
            .map([MyBookMarkResponseDTO].self)
            .map({$0.map{$0.toDomain()}})
    }
    
    func addBookMark(printShopId: Int, bookmarkGroupId: Int) -> RxSwift.Single<BaseEntity> {
        request(.addBookMark(printShopId: printShopId, bookmarkGroupId: bookmarkGroupId))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
            
    }
    
    func removeBookMark(id: Int) -> RxSwift.Single<BaseEntity> {
        request(.removeBookMark(id: id))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
        
    }
    
    func linkBookMark(bookMarkId: Int, groupId: Int) -> RxSwift.Single<BaseEntity> {
        request(.linkBookMark(bookMarkId: bookMarkId, groupId: groupId))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func generateBookMark(name: String) -> RxSwift.Single<BaseEntity> {
        request(.generateBookMark(name: name))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func removeBookMarkGroup(ids: [Int]) -> RxSwift.Single<BaseEntity> {
        request(.removeBookMarkGroup(ids: ids))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func fetchBookMarkDetail(id: Int) -> Single<[BookMarkDetailEntity]> {
        request(.fetchBookMarkDetail(id: id))
            .map([BookMarkDetailResponseDTO].self)
            .map{$0.map{$0.toDomain()}}
    }
    

}
