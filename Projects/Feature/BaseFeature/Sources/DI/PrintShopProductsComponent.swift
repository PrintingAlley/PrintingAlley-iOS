//
//  PrintShopProductsComponent.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/15.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import NeedleFoundation
import BaseFeatureInterface
import BaseDomainInterface

public final class PrintShopProductsComponent: Component<EmptyDependency>, PrintShopProductsFactory {
    public func makeView(products: [ProductEntity]) -> UIViewController {
        PrintShopProudctsViewController(viewModel: PrintShopProudctsViewModel(products: products))
    }
}
