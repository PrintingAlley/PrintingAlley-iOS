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

public protocol PrintShopProductsDependency: Dependency {
    var productDetailFactory: any ProductDetailFactory { get }
}

public final class PrintShopProductsComponent: Component<PrintShopProductsDependency>, PrintShopProductsFactory {
    public func makeView(products: [ProductEntity]) -> UIViewController {
        PrintShopProductsViewController(viewModel: PrintShopProductsViewModel(products: products), productDetailFactory: dependency.productDetailFactory)
    }
}
