//
//  BookMarkRepositoryImpl.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface
import RxSwift
import BaseDomainInterface

struct BookMarkRepositoryImpl: BookMarkRepository {

    

    
    private let remoteBookMarkDataSource: any RemoteBookMarkDataSource
    
    init(remoteBookMarkDataSource: any RemoteBookMarkDataSource) {
        self.remoteBookMarkDataSource = remoteBookMarkDataSource
    }
    
    func fetchMyBookMarks() -> Single<BookMarkGroupsEntity> {
        remoteBookMarkDataSource.fetchMyBookMarks()
    }
    
    func addBookMark(productId: Int, bookmarkGroupId: Int) -> Single<AddBookMarkEntity> {
        remoteBookMarkDataSource.addBookMark(productId: productId, bookmarkGroupId: bookmarkGroupId)
    }
    
    func removeBookMark(id: Int) -> Single<BaseEntity> {
        remoteBookMarkDataSource.removeBookMark(id: id)
    }
    
    func linkBookMark(bookMarkId: Int, groupId: Int) -> Single<BaseEntity> {
        remoteBookMarkDataSource.linkBookMark(bookMarkId: bookMarkId, groupId: groupId)
    }
    
    func generateBookMark(name: String) -> Single<BaseEntity> {
        remoteBookMarkDataSource.generateBookMark(name: name)
    }
    
    func removeBookMarkGroup(ids: [Int]) -> Single<BaseEntity> {
        remoteBookMarkDataSource.removeBookMarkGroup(ids: ids)
    }
    
    func fetchBookMarkDetail(id: Int) -> Single<BookMarkGroupEntity> {
        remoteBookMarkDataSource.fetchBookMarkDetail(id: id)
    }
    
    func renameBookMarkGroup(id: Int, name: String) -> Single<BaseEntity> {
        self.remoteBookMarkDataSource.renameBookMarkGroup(id: id, name: name)
    }
 
    


    
}
