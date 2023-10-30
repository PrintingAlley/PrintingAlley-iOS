//
//  CreateReviewUseCase.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public protocol CreateReviewUseCase {
    func execute(id: Int) -> BaseEntity
}
