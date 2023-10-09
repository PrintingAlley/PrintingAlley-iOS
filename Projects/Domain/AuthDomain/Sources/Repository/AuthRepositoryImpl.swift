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
    
    private let remoteAuthDataSource: any RemoteAuthDataSource
    
    init(remoteAuthDataSource: any RemoteAuthDataSource) {
        self.remoteAuthDataSource = remoteAuthDataSource
    }
    
    func fetchTest() -> Single<TestEntity> {
        remoteAuthDataSource.fetchTest()
    }
    
}
