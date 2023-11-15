//
//  PrintShopProductsFactory.swift
//  BaseFeatureInterface
//
//  Created by 박의서 on 2023/11/15.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import BaseDomainInterface

public protocol PrintShopProductsFactory {
    func makeView(products: [ProductEntity]) -> UIViewController
}
