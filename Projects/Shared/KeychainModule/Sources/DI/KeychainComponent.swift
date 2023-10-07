//
//  KeychainComponent.swift
//  KeychainModuleInterface
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import KeychainModuleInterface
import NeedleFoundation

public final class KeychainComponent: Component<EmptyDependency>, KeychainFactory {
    public var keychain: any Keychain {
        DefaultKeychain()
    }
}

