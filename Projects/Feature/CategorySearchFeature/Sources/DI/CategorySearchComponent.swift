//
//  CategorySearchComponent.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/27/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import SearchDomainInterface
import CategorySearchFeatureInterface
import TagDomainInterface
import UIKit

public protocol CategorySearchDependency: Dependency {
    
    var searchDomainFactory: any SearchDomainFactory { get }
    
}

public final class CategorySearchComponent: Component<CategorySearchDependency>, CategorySearchFactory {
    public func makeView(id: Int, title: String) -> UIViewController {
        CategorySearchViewController(viewModel: CategorySearchViewModel(title: title, id: id,fetchPrintShopListUseCase: dependency.searchDomainFactory.fetchPrintShopListUseCase))
    }
    
}
