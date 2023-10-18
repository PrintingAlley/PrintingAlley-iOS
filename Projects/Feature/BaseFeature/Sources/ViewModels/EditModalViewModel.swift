//
//  EditModalViewModel.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import UtilityModule
import BookMarkDomainInterface
import BaseFeatureInterface


public class EditModalViewModel: ViewModelType {
    
    var type: EditType!
    var generateBookMarkUseCase: any GenerateBookMarkUseCase
    //TODO: 프로필 이름 변경 유즈 케이스
    
    init(type: EditType!, generateBookMarkUseCase: GenerateBookMarkUseCase) {
        self.type = type
        self.generateBookMarkUseCase = generateBookMarkUseCase
    }
    
    public struct Input {
        let tapConfirm: PublishSubject<Void> = .init()
    }
    
    public struct Output {
        
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
    
        
        return output
    }
    
}
