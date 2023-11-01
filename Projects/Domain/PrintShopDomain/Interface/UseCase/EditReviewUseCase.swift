//
//  EditReviewUseCase.swift
//  PrintShopDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UserDomainInterface
import BaseDomainInterface
import RxSwift

public protocol EditReviewUseCase {
    func execute(id:Int,reviewId: Int, content: String, rating: Int, images: [String]) -> Single<BaseEntity>
}

