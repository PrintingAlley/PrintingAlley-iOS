//
//  Appcomponent+UserDomain.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UserDomainInterface
import UserDomain

extension AppComponent {
    var userDomainFactory: any UserDomainFactory {
        UserDomainComponent(parent: self)
    }
}
