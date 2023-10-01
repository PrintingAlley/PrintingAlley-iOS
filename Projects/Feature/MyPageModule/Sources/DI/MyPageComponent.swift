//
//  MyPageComponent.swift
//  MyPageModule
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import MyPageModuleInterface
import UIKit
import SignInFeatureInterface

public protocol MyPageDependency: Dependency {
    
    var signInFactory: any SigninFactory { get }
    var myPageContentFactory: any MyPageContentFactory { get }
    
}

public final class MyPageComponent: Component<MyPageDependency>, MyPageFactory {
    public func makeView() -> UIViewController {
        MyPageViewController()
    }
}
