//
//  TestRepository.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol AuthRepository {
    func login(accessToken: String, provider: String) -> Single<TokenEntity>
    func jwtTest() -> Single<TokenTestEntity>
    func logout() -> Single<BaseEntity>
    func withdraw() -> Single<BaseEntity>
}
