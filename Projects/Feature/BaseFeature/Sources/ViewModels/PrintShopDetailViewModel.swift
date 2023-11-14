//
//  PrintShopDetailViewModel.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/13.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
// TODO: - 폴더 이동하기
final class PrintShopDetailViewModel: ViewModelType {
    
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
