//
//  FetchPrintShopUseCaseImpl.swift
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

struct FetchPrintShopUseCaseImpl: FetchPrintShopUseCase {
    private let printShopRepository: any PrintShopRepository
    
    init(printShopRepository: PrintShopRepository) {
        self.printShopRepository = printShopRepository
    }
    
    func execute(id: Int) -> Single<PrintShopEntity> {
        printShopRepository.fetchPrintShop(id: id)
    }
}
