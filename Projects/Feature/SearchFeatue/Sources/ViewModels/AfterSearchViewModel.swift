//
//  AfterSearchViewModel.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/26.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import RxRelay
import RxSwift
import BaseDomainInterface
import SearchDomainInterface

final class AfterSearchViewModel: ViewModelType {
    var fetchPrintShopListUseCase: any FetchPrintShopListUseCase
    
    public init(fetchPrintShopListUseCase: any FetchPrintShopListUseCase) {
        self.fetchPrintShopListUseCase = fetchPrintShopListUseCase
    }
    
    struct Input {
        let text = BehaviorRelay<String>(value: "")
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
