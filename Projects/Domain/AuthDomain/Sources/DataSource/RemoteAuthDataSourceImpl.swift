//
//  RemoteAuthDataSourceImpl.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import AuthDomainInterface
import RxSwift

final class RemoteAuthDataSourceImpl: BaseRemoteDataSource<AuthAPI>, RemoteAuthDataSource {
    func loadJwtToken(accessToken: String, provider: String) -> Single<TokenEntity> {
        request(.login(token: accessToken, provider: provider))
            .map(TokenResponseDTO.self)
            .map{$0.toDomain()}
    }
}
