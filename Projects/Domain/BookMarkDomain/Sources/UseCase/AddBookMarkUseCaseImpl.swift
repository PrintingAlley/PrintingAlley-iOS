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

struct AddBookMarkUseCaseImpl: AddBookMarkUseCase {


    private let bookMarkRepository: any BookMarkRepository

    init(bookMarkRepository: any BookMarkRepository) {
        self.bookMarkRepository = bookMarkRepository
    }
    
    func execute(printShopId: Int, bookmarkGroupId: Int) ->Single<Void> {
        bookMarkRepository.addBookMark(printShopId: printShopId, bookmarkGroupId: bookmarkGroupId)
    }
    

    

}
