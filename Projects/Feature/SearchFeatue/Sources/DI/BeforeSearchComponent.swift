//
//  BeforeSearchComponent.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/27.
//  Copyright © 2023 com. All rights reserved.
//

import NeedleFoundation
import UIKit
import SearchFeatueInterface

public protocol BeforeSearchDependency: Dependency {
}

public final class BeforeSearchComponent: Component<BeforeSearchDependency>, BeforeSearchFactory {
    public func makeView() -> UIViewController {
        BeforeSearchViewController(viewModel: BeforeSearchViewModel())
    }
}
