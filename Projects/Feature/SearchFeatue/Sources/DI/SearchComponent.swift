//
//  SearchComponent.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import NeedleFoundation
import UIKit
import SearchFeatueInterface
import PrintShopDomainInterface
import BaseFeatureInterface

public protocol SearchDependency: Dependency {
    var printShopDomainFactory: any PrintShopDomainFactory { get }
    var printShopDetailFactory: any PrintShopDetailFactory { get }
}

public final class SearchComponent: Component<SearchDependency>, SearchFactory {
    public func makeView() -> UIViewController {
        SearchViewController(printShopDetailFactory: dependency.printShopDetailFactory, viewModel: SearchViewModel(fetchPrintShopListUseCase: dependency.printShopDomainFactory.fetchPrintShopListUseCase))
    }
}
