//
//  LocalAuthDataSourcesImpl.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface
import JwtStoreInterface

class  LocalAuthDataSourcesImpl: LocalAuthDataSource {
    
    private let jwtStore: any JwtStore
    
    init(jwtStore: any JwtStore) {
        self.jwtStore = jwtStore
    }
    func loadJwtToken() -> String {
        jwtStore.load(property: .accessToken)
    }
}
