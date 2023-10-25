//
//  SearchViewModel.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import RxRelay
import RxSwift
import BaseDomainInterface

public class SearchViewModel: ViewModelType {
    
    public struct Input {
        
    }
    
    public struct Output {
        var dataSource: BehaviorRelay<[PrintShopEntity]> = .init(value: [])
    }

    public func transform(input: Input) -> Output {
        let output = Output()

        return output
    }
}
