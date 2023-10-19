//
//  RemoteBookMarkDataSource.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Network
import RxSwift
import BaseDomainInterface

public protocol RemoteBookMarkDataSource {
    func fetchMyBookMarks() -> Single<[MyBookMarkEntity]>
    func addBookMark(printShopId: Int, bookmarkGroupId: Int) -> Single<BaseEntity>
    func removeBookMark(id: Int) -> Single<BaseEntity>
    func linkBookMark(bookMarkId: Int, groupId: Int) -> Single<BaseEntity>
    func generateBookMark(name: String) -> Single<BaseEntity>
    func removeBookMarkGroup(ids: [Int]) -> Single<BaseEntity>
    
}
