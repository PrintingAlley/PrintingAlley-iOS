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
import HomeFeatureInterface
import NearByMeFeatureInterface

public protocol MainTabDependency: Dependency {
    var mypageFactory: any MyPageFactory { get }
    var homeFactory: any HomeFactory { get }
    var nearByMeFactory: any NearByMeFactory { get }
}

public final class MainTabComponent: Component<MainTabDependency>, MainTabFactory {
    public func makeView() -> UIViewController {
        MainTabBarController(
            myPageFactory: dependency.mypageFactory,
            homeFactory: dependency.homeFactory,nearByMeFactory: dependency.nearByMeFactory
        )
    }
}
