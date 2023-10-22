//
//  RenameUserUseCase.swift
//  UserDomainInterface
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol RenameUserUseCase {
    func execute(name: String) -> Single<BaseEntity>
}
