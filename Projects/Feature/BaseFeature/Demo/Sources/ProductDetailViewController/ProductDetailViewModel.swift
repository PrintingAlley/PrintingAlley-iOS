//
//  ProductDetailViewModel.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule


final class ProductDetailViewModel: ViewModelType {
    
    var id: Int!
    
    init(id: Int) {
        self.id = id
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        
        return output
    }
}
