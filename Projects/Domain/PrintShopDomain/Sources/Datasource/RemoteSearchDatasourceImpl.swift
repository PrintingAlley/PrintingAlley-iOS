//
//  RemoteSearchDatasourceImpl.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import BaseDomainInterface
import PrintShopDomainInterface
import RxSwift
import BaseDomainInterface

final class RemotePrintShopDataSourceImpl: BaseRemoteDataSource<PrintShopAPI>, RemotePrintShopDataSource {
    func fetchPrintShopList(page: Int, searchText: String) -> Single<[PrintShopEntity]> {
        request(.list(page: page, searchText: searchText))
            .map([PrintShopResponseDTO].self)
            .map{$0.map{$0.toDomain()}}
    }
}
