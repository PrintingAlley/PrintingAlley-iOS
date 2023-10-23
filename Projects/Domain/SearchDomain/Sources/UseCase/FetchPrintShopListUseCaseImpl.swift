//
//  FetchPrintShopListUseCaseImpl.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SearchDomainInterface
import RxSwift

struct FetchPrintShopListUseCaseImpl: FetchPrintShopListUseCase {
    private let searchRepository: any SearchRepository
    
    func execute(searchText: String, tagIds: [Int]) -> Single<[PrintShopListEntity]> {
        searchRepository.fetchPrintShopList(searchText: searchText, tagIds: tagIds)
    }
}
