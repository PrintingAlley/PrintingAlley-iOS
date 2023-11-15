//
//  PrintShopProductsViewModel.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/14.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface
import UtilityModule
import RxRelay

class PrintShopProductsViewModel: ViewModelType {
    
    struct Input {

    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
    
    var products: [ProductEntity]!
    
    init(products: [ProductEntity]) {
        self.products = products
    }
}
