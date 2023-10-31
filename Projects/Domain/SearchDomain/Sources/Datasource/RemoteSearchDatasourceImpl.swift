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
import SearchDomainInterface
import RxSwift
import BaseDomainInterface

final class RemoteSearchDatasourceImpl: BaseRemoteDataSource<SearchAPI>, RemoteSearchDatasource {
    func fetchPrintShopList(searchText: String, tagIds: [Int]) -> Single<[PrintShopEntity]> {
        request(.list(searchText: searchText, tagIds: tagIds))
            .map([PrintShopResponseDTO].self)
            .map({$0.map {$0.toDomain()}})
    }
}
