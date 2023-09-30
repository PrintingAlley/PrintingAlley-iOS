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

public protocol MyPageDependency: Dependency {

}

public final class MyPageComponent: Component<MyPageDependency>,MyPageFactory {
    public func makeView() -> UIViewController {
        MyPageViewController()
    }
}
