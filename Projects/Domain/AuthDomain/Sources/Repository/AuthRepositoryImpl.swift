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
import BaseDomainInterface

struct AuthRepositoryImpl: AuthRepository {
    
    let disposeBag = DisposeBag()

    
    private let localAuthDataSource: any LocalAuthDataSource
    private let remoteAuthDataSource: any RemoteAuthDataSource
    
    init(localAuthDataSource: any LocalAuthDataSource, remoteAuthDataSource: any RemoteAuthDataSource) {
        self.remoteAuthDataSource = remoteAuthDataSource
        self.localAuthDataSource = localAuthDataSource
    }
    
    func login(accessToken: String, provider: String) -> Single<TokenEntity> {
        remoteAuthDataSource.loadJwtToken(accessToken: accessToken, provider: provider)
    }
    
    func verify() -> Single<VerifyEntity> {
        remoteAuthDataSource.verify()
    }
    
    func logout() -> Single<BaseEntity> {
    
       remoteAuthDataSource.logout()
        .do(onSuccess: { _ in
            localAuthDataSource.removeToken()
        })
        
    }
    
    func withdraw() -> Single<BaseEntity> {

        remoteAuthDataSource.withdraw()
        .do(onSuccess: { _ in
            localAuthDataSource.removeToken()
        })

    }
    
    func versionCheck(version: String) -> Single<VersionCheckEntity> {
        remoteAuthDataSource.versionCheck(version: version)
    }
    
}
