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
    func fetchTest() -> Single<TestEntity> {
        request(.testGet)
            .map(TestDTO.self)
            .map {$0.toDomain()}
            
    }
    
}
