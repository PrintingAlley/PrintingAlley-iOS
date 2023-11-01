//
//  CreateReviewUseCase.swift
//  PrintShopDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UserDomainInterface
import BaseDomainInterface
import RxSwift

public protocol CreateReviewUseCase {
    func execute(id:Int, content: String, rating: Int, images: [String]) -> Single<BaseEntity>
}
