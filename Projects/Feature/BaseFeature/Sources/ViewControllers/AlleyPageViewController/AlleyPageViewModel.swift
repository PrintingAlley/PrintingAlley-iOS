//
//  AlleyPageViewModel.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import RxSwift
import RxRelay

final class AlleyPageViewModel: ViewModelType {
  
    let disposeBag = DisposeBag()
    
    public var titles: [String] = []
    
    init(titles: [String]) {
        self.titles = titles
    }
    
    struct Input {
        let selectedIndex: BehaviorRelay<Int> = .init(value: 0)
    }
    
    struct Output {
        let barConstraints: PublishRelay<CGFloat> = .init()
     }

    func transform(input: Input) -> Output {
        
        let output = Output()
 
        input.selectedIndex
            .skip(1)
            .map({ [weak self]  index -> CGFloat in
                
                guard let self else {return .zero}
                
                return (APP_WIDTH() /  CGFloat(self.titles.count)) * CGFloat(index)
            })
            .bind(to: output.barConstraints)
            .disposed(by: disposeBag)
        return output
    }
    
}
