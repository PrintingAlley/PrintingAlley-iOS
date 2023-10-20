//
//  BookMarkViewModel.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import UtilityModule
import BookMarkDomainInterface


public final class BookMarkDetailViewModel: ViewModelType {
    
    
    var fetchBookMarkDetailUseCase: any FetchBookMarkDetailUseCase
    var removeBookMarkUseCase: any RemoveBookMarkUseCase
    
    init(fetchBookMarkDetailUseCase: FetchBookMarkDetailUseCase, removeBookMarkUseCase: RemoveBookMarkUseCase) {
        self.fetchBookMarkDetailUseCase = fetchBookMarkDetailUseCase
        self.removeBookMarkUseCase = removeBookMarkUseCase
    }
    
    public struct Input {
        
    }
    
    public struct Output {
        let dataSource: BehaviorRelay<[SimplePrintShopInfoEntity]> = .init(value: [])
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        
        return output
    }
    
    
 
    
}




