//
//  FetchHierachyUseCase.swift
//  TagDomainInterface
//
//  Created by yongbeomkwak on 10/23/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public protocol FetchHierarchyUseCase {
    func execute(id: Int) -> Single<HierarchyEntity>
}
