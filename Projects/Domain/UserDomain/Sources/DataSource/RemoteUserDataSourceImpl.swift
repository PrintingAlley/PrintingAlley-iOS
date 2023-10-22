//
//  RemoteUserDataSourceImpl.swift
//  UserDomain
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import UserDomainInterface
import RxSwift
import BaseDomainInterface


final class RemoteUserDataSourceImpl: BaseRemoteDataSource<UserAPI>, RemoteUserDataSource {
    func fetchUserInfo() -> Single<UserInfoEntity> {
        request(.fetchUserInfo)
            .map(FetchUserInfoResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func renameUser(name: String) -> Single<BaseEntity> {
        request(.renameUser(name: name))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
}
