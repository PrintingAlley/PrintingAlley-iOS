//
//  KeychainFactory.swift
//  KeychainModuleInterface
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
public protocol KeychainFactory {
    var keychain: any Keychain { get }
}
