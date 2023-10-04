//
//  AppComponent.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 2023/09/24.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import RootFeature

final class AppComponent: BootstrapComponent {
    func makeRootView() -> RootViewController {
        rootComponent.makeView()
    }
    
    var rootComponent: RootComponent {
        RootComponent(parent: self)
    }
}
