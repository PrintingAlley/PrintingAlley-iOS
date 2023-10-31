//
//  AppComponent+ProductDomain.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ProductDomainInterface
import ProductDomain


extension AppComponent {
    var productDomainFactory: any ProductDomainFactory {
        ProductDomainComponent(parent: self)
    }
}
