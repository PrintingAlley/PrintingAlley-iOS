//
//  DeleteReviewUseCase.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface
import RxSwift

public protocol DeleteReviewUseCase {
    func execute(id: Int, reviewId: Int) -> Single<BaseEntity>
}
