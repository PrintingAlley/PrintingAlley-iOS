//
//  WithDrawUseCase.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol WithDrawUseCase {
    func execute() -> Single<BaseEntity>
}
