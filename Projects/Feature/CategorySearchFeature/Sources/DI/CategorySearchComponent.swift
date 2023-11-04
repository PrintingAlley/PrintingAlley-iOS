//
//  CategorySearchComponent.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/27/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import CategorySearchFeatureInterface
import ProductDomainInterface
import TagDomainInterface
import UIKit

public protocol CategorySearchDependency: Dependency {
    var productDomainFactory: any ProductDomainFactory { get }
    var filterFactory: any FilterFactory { get }
    
}

public final class CategorySearchComponent: Component<CategorySearchDependency>, CategorySearchFactory {
    public func makeView(id: Int, title: String) -> UIViewController {
        CategorySearchViewController(filterFactory: dependency.filterFactory, viewModel: CategorySearchViewModel(title: title, id: id, fetchProductListUseCase: dependency.productDomainFactory.fetchProductListUseCase))
    }
    
}
