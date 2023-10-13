//
//  BaseLocalDataSourceImpl.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import JwtStoreInterface
import BaseDomainInterface
import Network

final class LocalAuthDataSourceImpl: BaseLocalDataSource {

    private let jwtStore: any JwtStore
    
    init(jwtStore: any JwtStore) {
        self.jwtStore = jwtStore
    }

    func loadJwtToken() -> String {
        jwtStore.load(property: .accessToken)
    }

}
