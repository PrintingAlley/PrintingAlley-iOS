//
//  AfterSearchComponent.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/27.
//  Copyright © 2023 com. All rights reserved.
//

import NeedleFoundation
import UIKit
import SearchFeatueInterface
import BaseDomainInterface

public protocol AfterSearchDependency: Dependency {
}

public final class AfterSearchComponent: Component<AfterSearchDependency>, AfterSearchFactory {
    public func makeView(dataSource: [PrintShopEntity]) -> UIViewController {
        AfterSearchViewController(viewModel: AfterSearchViewModel(dataSource: []))
    }
}
