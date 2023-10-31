//
//  FetchPrintShopReviewUseCaseImpl.swift
//  PrintShopDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import PrintShopDomainInterface
import BaseDomainInterface
import RxSwift
import BaseDomainInterface

struct FetchPrintShopReviewUseCaseImpl: FetchPrintShopReviewUseCase {
    private let printShopRepository: any PrintShopRepository
    
    init(printShopRepository: PrintShopRepository) {
        self.printShopRepository = printShopRepository
    }
    
    func execute(id: Int) -> Single<PrintShopReviewEntity> {
        printShopRepository.fetchPrintShopReview(id: id)
    }
}
