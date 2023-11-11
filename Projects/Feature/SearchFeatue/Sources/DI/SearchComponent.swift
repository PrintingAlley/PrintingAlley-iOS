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

public protocol SearchDependency: Dependency {
    var printShopDomainFactory: any PrintShopDomainFactory { get }
    var afterSearchFactory: any AfterSearchFactory { get }
}

public final class SearchComponent: Component<SearchDependency>, SearchFactory {
    public func makeView() -> UIViewController {
        SearchViewController(viewModel: SearchViewModel(fetchPrintShopListUseCase: dependency.printShopDomainFactory.fetchPrintShopListUseCase), afterSearchFactory: dependency.afterSearchFactory)
    }
}
