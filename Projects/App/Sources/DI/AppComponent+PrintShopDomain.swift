//
//  AppComponent+SearchDomain.swift
//  PrintingAlley
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import PrintShopDomain
import PrintShopDomainInterface

extension AppComponent {
    var printShopDomainFactory: any PrintShopDomainFactory {
        PrintShopDomainComponent(parent: self)
    }
}
