//
//  RemoteUserDataSource.swift
//  UserDomainInterface
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Network
import RxSwift
import BaseDomainInterface

public protocol RemoteUserDataSource {
    func fetchUserInfo() -> Single<UserInfoEntity>
    func renameUser(name: String) -> Single<BaseEntity>

    
}
