//
//  KeychainJwtStore.swift
//  JwtStore
//
//  Created by yongbeomkwak on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import JwtStoreInterface
import KeychainModuleInterface

struct KeychainJwtStore: JwtStore {
    private let keychain: any Keychain

    init(keychain: any Keychain) {
        self.keychain = keychain
    }

    func save(property: JwtStoreProperties, value: String) {
        self.keychain.save(key: property.rawValue, value: value)
    }

    func load(property: JwtStoreProperties) -> String {
        self.keychain.load(key: property.rawValue)
    }

    func delete(property: JwtStoreProperties) {
        self.keychain.delete(key: property.rawValue)
    }
}



