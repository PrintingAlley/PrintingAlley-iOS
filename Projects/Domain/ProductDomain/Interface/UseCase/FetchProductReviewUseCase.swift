//
//  FetchProductReviewUseCase.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface
import RxSwift

public protocol FetchProductReviewUseCase {
    func execute(id: Int) -> Single<[ProductReviewEntity]>
}

