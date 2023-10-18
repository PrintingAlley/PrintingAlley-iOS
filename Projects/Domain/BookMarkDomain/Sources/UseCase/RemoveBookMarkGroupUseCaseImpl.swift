//
//  RemoveBookMarkGroupUseCaseImpl.swift
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

struct RemoveBookMarkGroupUseCaseImpl: RemoveBookMarkGroupUseCase {

    private let bookMarkRepository: any BookMarkRepository

    init(bookMarkRepository: any BookMarkRepository) {
        self.bookMarkRepository = bookMarkRepository
    }
    
    func execute(id: Int) -> Single<BaseEntity> {
        bookMarkRepository.removeBookMarkGroup(id: id)
    }
    
 

}
