//
//  BaseRemoteDataSource.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Netwrok
import JwtStoreInterface
import Moya

open class BaseRemoteDataSource<API:AlleyAPI> {
    private let jwtStore: any JwtStore
    private let provider: MoyaProvider<API>
    private let decoder = JSONDecoder()
    private let maxRetryCount:Int = 2
    
    public init (jwtStore: any JwtStore, provider: MoyaProvider<API>? = nil) {
        self.jwtStore = jwtStore
        
        #if DEV
        self.provider = provider ?? MoyaProvider(plugins: [JwtPlugin(jwtStore: jwtStore), CustomLoggingPlugin()])
        #else
        self.provider = provider ?? MoyaProvider(plugins: [JwtPlugin(jwtStore: jwtStore)]) // PROD에는 로깅 필요 없음
        #endif
    }
    
}
