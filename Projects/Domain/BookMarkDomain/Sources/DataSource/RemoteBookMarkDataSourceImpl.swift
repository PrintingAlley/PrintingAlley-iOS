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
   
    
    func renameBookMarkGroup(id: Int, name: String) -> Single<BaseEntity> {
        request(.renameBookMarkGroup(id: id, name: name))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    

    
    func fetchMyBookMarks() -> RxSwift.Single<BookMarkGroupsEntity> {
        request(.myBookMark)
            .map(BookMarkGroupsResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func addBookMark(productId: Int, bookmarkGroupId: Int) -> RxSwift.Single<AddBookMarkEntity> {
        request(.addBookMark(productId: productId, groupId: bookmarkGroupId))
            .map(AddBookMarkResponseDTO.self)
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
    
    func fetchBookMarkDetail(id: Int) -> Single<BookMarkGroupEntity> {
        request(.fetchBookMarkDetail(id: id))
            .map(BookMarkGroupResponseDTO.self)
            .map{$0.toDomain()}
    }
    

}
