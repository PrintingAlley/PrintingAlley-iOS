//
//  AppComponent+Home.swift
//  PrintingAlley
//
//  Created by 박의서 on 2023/10/11.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import HomeFeature
import HomeFeatureInterface

extension AppComponent {
    var homeFactory: any HomeFactory {
        HomeComponent(parent: self)
    }
}
