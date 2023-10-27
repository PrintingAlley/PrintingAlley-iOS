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

final class AfterSearchViewModel: ViewModelType {
    private var dataSource: [PrintShopEntity]
    
    init(dataSource: [PrintShopEntity]) {
        self.dataSource = dataSource
    }
    
    public struct Input {
        let text = BehaviorRelay<String>(value: "")
    }
    
    public struct Output {
        let dataSource: BehaviorRelay<[PrintShopEntity]> = .init(value: [])
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()

        return output
    }
}
