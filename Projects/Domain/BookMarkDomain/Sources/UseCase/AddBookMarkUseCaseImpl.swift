//
//  AddBookMarkUseCaseImpl.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import Network
import BookMarkDomainInterface
import BaseDomainInterface

struct AddBookMarkUseCaseImpl: AddBookMarkUseCase {


    private let bookMarkRepository: any BookMarkRepository

    init(bookMarkRepository: any BookMarkRepository) {
        self.bookMarkRepository = bookMarkRepository
    }
    
    func execute(productId: Int, bookmarkGroupId: Int) -> Single<BaseEntity> {
        bookMarkRepository.addBookMark(productId: productId, bookmarkGroupId: bookmarkGroupId)
    }
    

    

}
