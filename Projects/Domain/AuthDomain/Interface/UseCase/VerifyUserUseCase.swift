//
//  fetchTokenTest.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

public protocol VerifyUserUseCase {
    func execute() -> Single<VerifyEntity>
}
