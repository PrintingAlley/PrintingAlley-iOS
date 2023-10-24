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
   
    
    
    
    public var fetchLoginUseCase: any FetchLoginUseCase {
        FetchLoginUseCaseImpl(authRepository: authRepository)
    }
    
    public var verifyUserUseCase: any VerifyUserUseCase {
        VerifyUserUseCaseImpl(authRepository: authRepository)
    }
    
    public var logOutUseCase: any LogOutUseCase {
        LogOutUseCaseImpl(authRepository: authRepository)
    }
    
    public var withDrawUseCase: any WithDrawUseCase {
        WithDrawUseCaseImpl(authRepository: authRepository)
    }
    
    public var authRepository: any AuthRepository {
        AuthRepositoryImpl(
            localAuthDataSource: localAuthDataSource, remoteAuthDataSource: remoteAuthDataSource
        )
    }
    
    
    
    var remoteAuthDataSource: any RemoteAuthDataSource {
        RemoteAuthDataSourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    }
    
    var localAuthDataSource: any LocalAuthDataSource {
        LocalAuthDataSourcesImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    }
    
}
