//
//  BaseLocalDataSource.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Network
import RxSwift

public protocol RemoteAuthDataSource {
    func loadJwtToken(accessToken:String, provider:String) -> Single<TokenEntity>
    func jwtTest() -> Single<TokenTestEntity>
    
}
