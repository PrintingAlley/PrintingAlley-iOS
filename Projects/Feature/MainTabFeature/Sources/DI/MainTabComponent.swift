//
//  MainTabComponent.swift
//  MainTabFeatureInterface
//
//  Created by 박의서 on 2023/10/10.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import UIKit
import MainTabFeatureInterface
import MyPageFeatureInterface

public protocol MainTabDependency: Dependency {
    var myPageFactory: any MyPageFactory { get }
}

public final class MainTabComponent: Component<MainTabDependency>, MainTabFactory {
    public func makeView() -> UIViewController {
        MainTabBarController()
    }
}
