//
//  EditReviewUseCase.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface
import RxSwift

public protocol EditReviewUseCase {
    func execute(id: Int, reviewId: Int, content: String, rating: Float, images: [String]) -> Single<BaseEntity>
}
