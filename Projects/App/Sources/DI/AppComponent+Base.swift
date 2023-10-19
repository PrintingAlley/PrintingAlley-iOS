//
//  AppComponent+Base.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import BaseFeature

extension AppComponent {
    var baseFactory: any BaseFactory {
        BaseComponent(parent: self)
    }
}
