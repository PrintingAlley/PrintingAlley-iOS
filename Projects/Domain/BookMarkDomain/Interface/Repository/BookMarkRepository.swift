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
    func fetchMyBookMarks() -> Single<BookMarkGroupsEntity>
    func addBookMark(productId: Int, bookmarkGroupId: Int) -> Single<AddBookMarkEntity>
    func removeBookMark(id: Int) -> Single<BaseEntity>
    func linkBookMark(bookMarkId: Int, groupId: Int) -> Single<BaseEntity>
    func generateBookMark(name: String) -> Single<BaseEntity>
    func removeBookMarkGroup(ids: [Int]) -> Single<BaseEntity>
    func fetchBookMarkDetail(id: Int) -> Single<BookMarkGroupEntity>
    func renameBookMarkGroup(id:Int, name: String) -> Single<BaseEntity>
    
}
