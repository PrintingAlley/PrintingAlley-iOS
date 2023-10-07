//
//  AppComponent+JwtStore.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import JwtStoreInterface
import JwtStore

extension AppComponent {
    var jwtStoreFactory: any JwtStoreFactory {
        JwtStoreComponent(parent: self)
    }
}
