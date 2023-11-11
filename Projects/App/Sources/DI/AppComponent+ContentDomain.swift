//
//  AppComponent+ContentDomain.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ContentDomainInterface
import ContentDomain

extension AppComponent {
    var contentDomainFactory: any ContentDomainFactory {
        ContentDomainComponent(parent: self)
    }
}
