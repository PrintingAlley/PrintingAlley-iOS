//
//  FetchPrintShopReviewUseCase.swift
//  PrintShopDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface
import RxSwift

public protocol FetchPrintShopReviewUseCase {
    func execute(id:Int ) -> Single<PrintShopReviewEntity>
}
