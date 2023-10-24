//
//  UserRepositoryImpl.swift
//  UserDomain
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UserDomainInterface
import RxSwift
import BaseDomainInterface

struct UserRepositoryImpl: UserRepository {

    
    private let remoteUserDataSource: any RemoteUserDataSource
    
    init(remoteUserDataSource: any RemoteUserDataSource) {
        self.remoteUserDataSource = remoteUserDataSource
    }
    
    func fetchUserInfo() -> Single<UserInfoEntity> {
        remoteUserDataSource.fetchUserInfo()
    }
    
    func renameUser(name: String) -> Single<BaseEntity> {
        remoteUserDataSource.renameUser(name: name)
    }
    
}
