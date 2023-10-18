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

struct BookMarkRepositoryImpl: BookMarkRepository {
    
    
    
    private let remoteBookMarkDataSource: any RemoteBookMarkDataSource
    
    init(remoteBookMarkDataSource: any RemoteBookMarkDataSource) {
        self.remoteBookMarkDataSource = remoteBookMarkDataSource
    }
    
    func fetchMyBookMarks() -> Single<MyBookMarkEntity> {
        remoteBookMarkDataSource.fetchMyBookMarks()
    }
    
    func addBookMark(printShopId: Int, bookmarkGroupId: Int) -> Single<Void> {
        remoteBookMarkDataSource.addBookMark(printShopId: printShopId, bookmarkGroupId: bookmarkGroupId)
    }
    
    func removeBookMark(id: Int) -> Single<Void> {
        remoteBookMarkDataSource.removeBookMark(id: id)
    }
    
    func linkBookMark(bookMarkId: Int, groupId: Int) -> Single<Void> {
        remoteBookMarkDataSource.linkBookMark(bookMarkId: bookMarkId, groupId: groupId)
    }
    
    func generateBookMark(name: String) -> Single<Void> {
        remoteBookMarkDataSource.generateBookMark(name: name)
    }
    
    func removeBookMarkGroup(id: Int) -> Single<Void> {
        remoteBookMarkDataSource.removeBookMarkGroup(id: id)
    }
    
 
    


    
}
