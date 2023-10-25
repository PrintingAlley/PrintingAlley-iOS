//
//  AppComponent+TagDomain.swift
//  PrintingAlley
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import TagDomainInterface
import TagDomain

extension AppComponent {
    var tagDomainFactory: any TagDomainFactory {
        TagDomainComponent(parent: self)
    }
}
