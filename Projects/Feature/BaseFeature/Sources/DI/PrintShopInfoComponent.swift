//
//  PrintShopInfoComponent.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/15.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import NeedleFoundation
import BaseDomainInterface
import BaseFeatureInterface

public final class PrintShopInfoComponent: Component<EmptyDependency>, PrintShopInfoFactory {
    public func makeView(printShop: PrintShopEntity) -> UIViewController {
        PrintShopInfoViewController(viewModel: PrintShopInfoViewModel(printShop: printShop))
    }
}
