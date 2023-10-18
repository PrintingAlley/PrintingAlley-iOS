//
//  BookMarkRepository.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface


public protocol BookMarkRepository {
    func fetchMyBookMarks() -> Single<[MyBookMarkEntity]>
    func addBookMark(printShopId: Int, bookmarkGroupId: Int) -> Single<BaseEntity>
    func removeBookMark(id: Int) -> Single<BaseEntity>
    func linkBookMark(bookMarkId: Int, groupId: Int) -> Single<BaseEntity>
    func generateBookMark(name: String) -> Single<BaseEntity>
    func removeBookMarkGroup(id: Int) -> Single<BaseEntity>
    
}
