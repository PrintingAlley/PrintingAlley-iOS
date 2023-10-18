//
//  AddBookMarkUseCase.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public protocol AddBookMarkUseCase {
    func execute(printShopId: Int, bookmarkGroupId: Int) -> Single<Void>
}
