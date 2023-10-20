//
//  RenameBookMarkGroupUseCase.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol RenameBookMarkGroupUseCase {
    func execute(id:Int, name: String) -> Single<RenameBookMarkEntity>
}
