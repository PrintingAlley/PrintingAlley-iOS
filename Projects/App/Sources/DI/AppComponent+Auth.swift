//
//  AppComponent+Auth.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import AuthDomainInterface
import AuthDomain

extension AppComponent {
    var authDomainFactory: any AuthDomainFactory {
        AuthDomainComponent(parent: self)
    }
}
