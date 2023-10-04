//
//  RootComponent.swift
//  RooFuture
//
//  Created by yongbeomkwak on 2023/09/24.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation


public protocol RootDependency: Dependency {

}

public final class RootComponent: Component<RootDependency> {
    public func makeView() -> RootViewController {
        return RootViewController()
    }
}
