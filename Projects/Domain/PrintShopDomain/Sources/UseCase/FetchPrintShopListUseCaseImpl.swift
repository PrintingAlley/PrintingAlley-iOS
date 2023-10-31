//
//  FetchPrintShopListUseCaseImpl.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import PrintShopDomainInterface
import BaseDomainInterface
import RxSwift
import BaseDomainInterface

struct FetchPrintShopListUseCaseImpl: FetchPrintShopListUseCase {
    private let printShopRepository: any PrintShopRepository
    
    init(printShopRepository: PrintShopRepository) {
        self.printShopRepository = printShopRepository
    }
    
    func execute(page:Int, searchText: String) -> Single<[PrintShopEntity]> {
        printShopRepository.fetchPrintShopList(page: page,searchText: searchText)
    }
}
