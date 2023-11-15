//
//  PrintShopDetailComponent.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/13.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import NeedleFoundation
import BaseFeatureInterface

public protocol PrintShopDetailDependency: Dependency {
    var printShopInfoFactory: any PrintShopInfoFactory { get }
    var printShopProductsFactory: any PrintShopProductsFactory { get }
}

public final class PrintShopDetailComponent: Component<PrintShopDetailDependency>, PrintShopDetailFactory {
    public func makeView(id: Int) -> UIViewController {
        PrintShopDetailViewController(printShopInfoFactory: dependency.printShopInfoFactory, printShopProductsFactory: dependency.printShopProductsFactory, viewModel: PrintShopDetailViewModel(id: id))
    }
}
