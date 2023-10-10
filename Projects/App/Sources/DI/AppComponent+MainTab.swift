//
//  AppComponent+MainTab.swift
//  PrintingAlley
//
//  Created by 박의서 on 2023/10/10.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import MainTabFeatureInterface
import MainTabFeature

extension AppComponent {
    var mainTabFactory: any MainTabFactory {
        MainTabComponent(parent: self)
    }
}
