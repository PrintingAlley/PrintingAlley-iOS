//
//  NearByMeComponent.swift
//  NearByMeFeature
//
//  Created by yongbeomkwak on 10/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import NeedleFoundation
import NearByMeFeatureInterface
import UIKit

public protocol NearByMeDependency: Dependency {
 
}

public final class NearByMeComponent: Component<NearByMeDependency>, NearByMeFactory {
    public func makeView() -> UIViewController {
        return NearByMeViewController()
    }
}
