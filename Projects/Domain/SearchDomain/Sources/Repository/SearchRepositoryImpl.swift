//
//  SearchRepositoryImpl.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SearchDomainInterface
import RxSwift

struct SearchRepositoryImpl: SearchRepository {
    private let remoteSearchDatasource: any RemoteSearchDatasource
    
    init(remoteSearchDatasource: any RemoteSearchDatasource) {
        self.remoteSearchDatasource = remoteSearchDatasource
    }
    
    func fetchPrintShopList(searchText: String, tagIds: [Int]) -> Single<[PrintShopListEntity]> {
        remoteSearchDatasource.fetchPrintShopList(searchText: searchText, tagIds: tagIds)
    }
}
