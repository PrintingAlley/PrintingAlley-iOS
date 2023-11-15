//
//  PrintShopProductsViewModel.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/14.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

class PrintShopProductsViewModel {
    
    var products: [ProductEntity]!
    
    init(products: [ProductEntity]) {
        self.products = products
    }
}
