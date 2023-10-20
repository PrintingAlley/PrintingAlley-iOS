//
//  RenameBookMarkGroupUseCaseImpl.swift
//  BookMarkDomain
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import Network
import BookMarkDomainInterface
import BaseDomainInterface

struct RenameBookMarkGroupUseCaseImpl: RenameBookMarkGroupUseCase {
   
    

    private let bookMarkRepository: any BookMarkRepository

    init(bookMarkRepository: any BookMarkRepository) {
        self.bookMarkRepository = bookMarkRepository
    }
    
    func execute(id: Int, name: String) -> Single<RenameBookMarkEntity> {
        bookMarkRepository.renameBookMarkGroup(id: id, name: name)
    }
    
 

}
