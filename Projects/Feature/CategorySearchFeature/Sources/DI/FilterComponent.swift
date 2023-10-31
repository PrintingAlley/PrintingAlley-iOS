//
//  FilterComponent.swift
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

public protocol FilterDependency: Dependency {
    
    var tagDomainFactory: any TagDomainFactory { get }
    
}

public final class FilterComponent: Component<FilterDependency>, FilterFactory {
    public func makeView(id: Int) -> UIViewController {
        FilterViewController(viewModel: FilterViewModel(id: id,fetchTagUseCase: dependency.tagDomainFactory.fetchTagUseCase))
    }
    }
