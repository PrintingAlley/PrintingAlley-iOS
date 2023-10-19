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
import BaseDomainInterface

public class EditModalViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    var type: EditType!
    var generateBookMarkUseCase: any GenerateBookMarkUseCase
    //TODO: 프로필 이름 변경 유즈 케이스
    
    init(type: EditType!, generateBookMarkUseCase: GenerateBookMarkUseCase) {
        self.type = type
        self.generateBookMarkUseCase = generateBookMarkUseCase
    }
    
    public struct Input {
        let tapConfirm: PublishSubject<Void> = .init()
        let text:BehaviorRelay<String> = .init(value: "")
    }
    
    public struct Output {
        let result:PublishSubject<BaseEntity> = .init()
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        

        input.tapConfirm
            .withLatestFrom(input.text){($1)}
            .flatMap({ [weak self] text -> Observable<BaseEntity> in
                
                guard let self else { return Observable.empty()}
                
                return self.generateBookMarkUseCase.execute(name: text)
                    .asObservable()
            })
            .bind(to: output.result)
            .disposed(by: disposeBag)
    
        
        return output
    }
    
}
