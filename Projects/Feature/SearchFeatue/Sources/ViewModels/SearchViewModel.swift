//
//  SearchViewModel.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import RxRelay
import RxSwift
import BaseDomainInterface
import SearchDomainInterface

public class SearchViewModel: ViewModelType {
    
    var fetchPrintShopListUseCase: FetchPrintShopListUseCase!
    
    let disposeBag = DisposeBag()
    
    init(fetchPrintShopListUseCase: FetchPrintShopListUseCase) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
        self.fetchPrintShopListUseCase = fetchPrintShopListUseCase
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    public struct Input {
        let textString: BehaviorRelay<String> = BehaviorRelay(value: "")
    }
    
    public struct Output {
    }

    public func transform(input: Input) -> Output {
        let output = Output()

        return output
    }
}
