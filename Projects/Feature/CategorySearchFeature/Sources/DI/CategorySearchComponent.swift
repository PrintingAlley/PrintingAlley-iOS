//
//  CategorySearchComponent.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/27/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import PrintShopDomainInterface
import CategorySearchFeatureInterface
import TagDomainInterface
import UIKit

public protocol CategorySearchDependency: Dependency {
    
    var printShopDomainFactory: any PrintShopDomainFactory { get }
    var filterFactory: any FilterFactory { get }
    
}

public final class CategorySearchComponent: Component<CategorySearchDependency>, CategorySearchFactory {
    public func makeView(id: Int, title: String) -> UIViewController {
        CategorySearchViewController(filterFactory: dependency.filterFactory, viewModel: CategorySearchViewModel(title: title, id: id,fetchPrintShopListUseCase: dependency.printShopDomainFactory.fetchPrintShopListUseCase))
    }
    
}
