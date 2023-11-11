//
//  CreateReviewUseCaseImpl.swift
//  PrintShopDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import PrintShopDomainInterface
import BaseDomainInterface
import RxSwift
import BaseDomainInterface

struct CreateReviewUseCaseImpl: CreateReviewUseCase {
    private let printShopRepository: any PrintShopRepository
    
    init(printShopRepository: PrintShopRepository) {
        self.printShopRepository = printShopRepository
    }
    
    func execute(id: Int, content: String, rating: Int, images: [String]) -> Single<BaseEntity> {
        printShopRepository.createReview(id: id, content: content, rating: rating, images: images)
    }
}
