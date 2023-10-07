//
//  Keychain.swift
//  KeychainModuleInterface
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
public protocol Keychain {
    func save(key: String, value: String)
    func load(key: String) -> String
    func delete(key: String)
}
