//
//  HomeComponent.swift
//  HomeFeatureInterface
//
//  Created by 박의서 on 2023/10/11.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import UIKit
import HomeFeatureInterface

public protocol HomeDependency: Dependency {
    var homeFactory: any HomeFactory { get }
}

public final class HomeComponent: Component<HomeDependency>, HomeFactory {
    public func makeView() -> UIViewController {
        HomeViewController()
    }
}
