//
//  BookMarkRepository.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public protocol BookMarkRepository {
    func fetchMyBookMarks() -> Single<MyBookMarkEntity>
    func addBookMark(printShopId: Int, bookmarkGroupId: Int) -> Single<Void>
    func removeBookMark(id: Int) -> Single<Void>
    func linkBookMark(bookMarkId: Int, groupId: Int) -> Single<Void>
    func generateBookMark(name: String) -> Single<Void>
    func removeBookMarkGroup(id: Int) -> Single<Void>
    
}
