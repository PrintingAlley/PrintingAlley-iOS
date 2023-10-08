//
//  AppComponent+Keychain.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import KeychainModuleInterface
import KeychainModule

extension AppComponent {
    var keychainFactory: any KeychainFactory {
        KeychainComponent(parent: self)
    }
}
