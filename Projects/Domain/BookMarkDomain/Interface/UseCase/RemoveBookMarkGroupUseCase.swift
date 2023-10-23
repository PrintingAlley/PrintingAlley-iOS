//
//  RemoveBookMarkGroupUseCase.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol RemoveBookMarkGroupUseCase {
    func execute(ids: [Int]) -> Single<BaseEntity>
}
