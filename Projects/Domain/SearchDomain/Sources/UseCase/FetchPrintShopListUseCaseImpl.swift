//
//  FetchPrintShopListUseCaseImpl.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SearchDomainInterface
import BaseDomainInterface
import RxSwift

struct FetchPrintShopListUseCaseImpl: FetchPrintShopListUseCase {
    private let searchRepository: any SearchRepository
    
    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func execute(searchText: String, tagIds: [Int]) -> Single<[PrintShopEntity]> {
        searchRepository.fetchPrintShopList(searchText: searchText, tagIds: tagIds)
    }
}
