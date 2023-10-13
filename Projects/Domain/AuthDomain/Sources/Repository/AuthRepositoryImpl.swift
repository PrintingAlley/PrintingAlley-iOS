//
//  AuthRepositoryImpl.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface
import RxSwift

struct AuthRepositoryImpl: AuthRepository {
 
    

    private let localAuthDataSource: any LocalAuthDataSource
    private let remoteAuthDataSource: any RemoteAuthDataSource
    
    init(localAuthDataSource: any LocalAuthDataSource, remoteAuthDataSource: any RemoteAuthDataSource) {
        self.remoteAuthDataSource = remoteAuthDataSource
        self.localAuthDataSource = localAuthDataSource
    }
    
    func login(accessToken: String, provider: String) -> Single<TokenEntity> {
        remoteAuthDataSource.loadJwtToken(accessToken: accessToken, provider: provider)
    }
    
    func jwtTest() -> Single<TokenTestEntity> {
        remoteAuthDataSource.jwtTest()
    }
    
    
}
