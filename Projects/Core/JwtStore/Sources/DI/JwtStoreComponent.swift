//
//  JwtStoreComponent.swift
//  JwtStore
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import JwtStoreInterface
import KeychainModuleInterface
import NeedleFoundation

public protocol JwtStoreDependency: Dependency {
    var keychainFactory: any KeychainFactory { get }
}

public final class JwtStoreComponent: Component<JwtStoreDependency>, JwtStoreFactory {
    public var jwtStore: any JwtStore {
        KeychainJwtStore(keychain: dependency.keychainFactory.keychain)
    }
}
