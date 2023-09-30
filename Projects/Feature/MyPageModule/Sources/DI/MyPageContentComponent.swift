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

public protocol MyPageContentDependency: Dependency {

}

public final class MyPageContentComponent: Component<MyPageContentDependency>,MyPageContentFactory {
    public func makeView() -> UIViewController {
        MyPageContentViewController()
    }
}
