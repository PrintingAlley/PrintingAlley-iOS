//
//  EditModalViewModel.swift
//  DesignSystem
//
//  Created by yongbeomkwak on 10/16/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

public class BookMarkBottomSheetViewModel {
    
    struct Input {
       
    }
    
    struct Output {
        var dataSource: BehaviorRelay<[TmpModel]> = .init(value: TmpModel.makeDummy())
    }
    
    
    func transform(input: Input) -> Output {
        
        let output = Output()
        
    
        
        return output
    }
    
}