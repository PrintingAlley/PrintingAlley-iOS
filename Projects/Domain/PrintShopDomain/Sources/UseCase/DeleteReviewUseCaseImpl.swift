//
//  DeleteReviewUseCaseImpl.swift
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

struct DeleteReviewUseCaseImpl: DeleteReviewUseCase {
    private let printShopRepository: any PrintShopRepository
    
    init(printShopRepository: PrintShopRepository) {
        self.printShopRepository = printShopRepository
    }
    
    func execute(id: Int, reviewId: Int) -> Single<BaseEntity> {
        printShopRepository.deleteReview(id: id, reviewId: reviewId)
    }
}

