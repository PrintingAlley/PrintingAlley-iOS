//
//  AppComponent+NearByMe.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 10/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NearByMeFeatureInterface
import NearByMeFeature

extension AppComponent {
    var nearByMeFactory: any NearByMeFactory {
        NearByMeComponent(parent: self)
    }
}
