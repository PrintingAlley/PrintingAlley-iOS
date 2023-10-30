//
//  FetchProductUseCase.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public protocol FetchProductUseCase {
    func execute(id: Int) -> ProductEntity
}
