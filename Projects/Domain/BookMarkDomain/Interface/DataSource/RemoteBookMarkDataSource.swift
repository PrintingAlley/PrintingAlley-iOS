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
    func fetchMyBookMarks() -> Single<BookMarkGroupsEntity> // 북마크 그룹 가져오기
    func addBookMark(productId: Int, bookmarkGroupId: Int) -> Single<AddBookMarkEntity> // 북마크 그룹에 추가하기
    func removeBookMark(id: Int) -> Single<BaseEntity> // 북마크 삭제
    func linkBookMark(bookMarkId: Int, groupId: Int) -> Single<BaseEntity> // 연결하기
    func generateBookMark(name: String) -> Single<BaseEntity> // 북마크 그룹 생성
    func removeBookMarkGroup(ids: [Int]) -> Single<BaseEntity> // 북마크 그룹 삭제
    func fetchBookMarkDetail(id: Int) -> Single<BookMarkGroupEntity> // 북마크 그룹 디테일 가져오기
    func renameBookMarkGroup(id:Int, name: String) -> Single<BaseEntity>  // 북마크 그룹 이름 수정
    
}
