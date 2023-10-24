//
//  UserDomainFactory.swift
//  UserDomain
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import NeedleFoundation
import UserDomainInterface
import JwtStoreInterface

public protocol UserDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
}

public final class UserDomainComponent: Component<UserDomainDependency>, UserDomainFactory {
    public var fetchUserInfoUseCase: any FetchUserInfoUseCase {
        FetchUserInfoUseCaseImpl(userRepository: userRepository)
    }
    
    public var renameUserUseCase: any RenameUserUseCase {
        RenameUserUseCaseImpl(userRepository: userRepository)
    }
    
    
    private var userRepository: any UserRepository {
        UserRepositoryImpl(remoteUserDataSource: remoteUserDataSource)
    }
    
    private var remoteUserDataSource: any RemoteUserDataSource {
        RemoteUserDataSourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    }
    
}
