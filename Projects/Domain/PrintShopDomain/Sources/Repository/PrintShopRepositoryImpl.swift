//
//  SearchRepositoryImpl.swift
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

struct PrintShopRepositoryImpl: PrintShopRepository {

    
    private let remotePrintShopDataSource: any RemotePrintShopDataSource
    
    init(remotePrintShopDataSource: any RemotePrintShopDataSource) {
        self.remotePrintShopDataSource = remotePrintShopDataSource
    }
    
    func fetchPrintShopList(page: Int, searchText: String) -> Single<[PrintShopEntity]> {
        remotePrintShopDataSource.fetchPrintShopList(page: page, searchText: searchText)
    }
    
}
