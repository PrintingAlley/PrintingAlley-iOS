//
//  AuthDomainComponent.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import NeedleFoundation
import AuthDomainInterface
import JwtStoreInterface

public protocol AuthDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
}

public final class AuthDomainComponent: Component<AuthDomainDependency>, AuthDomainFactory {
    public var testGetUseCase: any TestGetUseCase {
        TestGetUseCaseImpl(authRepository: authRepository)
    }
    
    public var authRepository: any AuthRepository {
        AuthRepositoryImpl(
            remoteAuthDataSource: remoteAuthDataSource
        )
    }
    
    var remoteAuthDataSource: any RemoteAuthDataSource {
        RemoteAuthDataSourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    }
    
}
