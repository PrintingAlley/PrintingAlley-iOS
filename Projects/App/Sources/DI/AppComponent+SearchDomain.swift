//
//  AppComponent+SearchDomain.swift
//  PrintingAlley
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SearchDomain
import SearchDomainInterface

extension AppComponent {
    var searchDomainFactory: any SearchDomainFactory {
        SearchDomainComponent(parent: self)
    }
}
