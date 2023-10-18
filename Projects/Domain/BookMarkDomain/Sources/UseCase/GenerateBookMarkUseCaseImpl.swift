//
//  GenerateBookMarkUseCaseImpl.swift
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

struct GenerateBookMarkUseCaseImpl: GenerateBookMarkUseCase {

    private let bookMarkRepository: any BookMarkRepository

    init(bookMarkRepository: any BookMarkRepository) {
        self.bookMarkRepository = bookMarkRepository
    }
    
    func execute(name: String) -> Single<BaseEntity> {
        bookMarkRepository.generateBookMark(name: name)
    }
    

    

}
