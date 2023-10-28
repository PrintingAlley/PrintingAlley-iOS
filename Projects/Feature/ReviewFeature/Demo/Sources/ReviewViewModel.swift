//
//  ReviewViewModel.swift
//  ReviewFeatureDemo
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import RxSwift
import RxRelay


class ReviewViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let dataSource: PublishSubject<Data> = .init()
    }
    
    struct Output {
        let dataSource: PublishRelay<Data> = .init()
    }
    
    
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.dataSource
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        return output
    }
    
}
