//
//  AppComponent+CategorySearch.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 10/27/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import CategorySearchFeatureInterface
import CategorySearchFeature

extension AppComponent {
    var categorySearchFactory: any CategorySearchFactory {
        CategorySearchComponent(parent: self)
    }
}

