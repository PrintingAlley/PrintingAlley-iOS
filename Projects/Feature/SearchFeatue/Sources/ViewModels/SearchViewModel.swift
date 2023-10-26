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

public class SearchViewModel: ViewModelType {
    let disposeBag = DisposeBag()
    
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
