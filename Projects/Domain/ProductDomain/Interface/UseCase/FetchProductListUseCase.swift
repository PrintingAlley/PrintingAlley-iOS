//
//  FetchProductListUseCase.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public protocol FetchProductListUseCase {
    func execute() -> ProductListEntity
}
