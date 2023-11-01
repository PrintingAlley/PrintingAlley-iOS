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
import UtilityModule

public class BookMarkBottomSheetViewModel: ViewModelType {
     
    
    var id: Int!
    

    public struct Input {
       
    }
    
    public struct Output {
        var dataSource: BehaviorRelay<[TmpModel]> = .init(value: TmpModel.makeDummy())
    }
    
    init(id: Int) {
        self.id = id
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
    
        
        return output
    }
    
}
