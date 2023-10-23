//
//  AppComponent+BookMarkDomain.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BookMarkDomainInterface
import BookMarkDomain

extension AppComponent {
    var bookMarkDomainFactory: any BookMarkDomainFactory {
        BookMarkDomainComponent(parent: self)
    }
}
