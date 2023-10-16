//
//  TestGetUseCase.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import Network

public protocol FetchLoginUseCase {
    func execute(accessToken: String, provider: String) -> Single<TokenEntity>
}
