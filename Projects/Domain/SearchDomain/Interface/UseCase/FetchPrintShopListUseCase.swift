//
//  FetchPrintShopListUseCase.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public protocol FetchPrintShopListUseCase {
    func execute(searchText: String, tagIds: [Int]) -> Single<[PrintShopListEntity]>
}
