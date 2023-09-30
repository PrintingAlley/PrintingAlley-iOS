//
//  AppComponent+SignIn.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 2023/09/29.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SignInFeatureInterface
import SignInFeature

extension AppComponent {
    var signInFactory: any SigninFactory {
        SignInComponent(parent: self)
    }
}
