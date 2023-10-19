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
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    public struct Input {
        let tapConfirm: PublishSubject<Void> = .init()
        let text:BehaviorRelay<String> = .init(value: "")
    }
    
    public struct Output {
        let showToast:PublishSubject<BaseEntity> = .init()
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
        bindTapConfirm(input: input, output: output)

       
        
        return output
    }
    
}

///input
extension EditModalViewModel {
    func bindTapConfirm(input: Input, output: Output) {
        input.tapConfirm
            .withLatestFrom(input.text){($1)}
            .flatMap({ [weak self] text -> Observable<BaseEntity> in
                
                guard let self else { return Observable.empty()}
                 
                return self.generateBookMarkUseCase.execute(name: text)
                    .catch({ error in
                        
                        let alleryError = error.asAlleyError
                        
                        if alleryError == .tokenExpired {
                            return Single<BaseEntity>.create { single in
                                single(.success(BaseEntity(statusCode: 401, message: alleryError.errorDescription)))
                                return Disposables.create()
                            }
                        }
                        
                        return Single<BaseEntity>.create { single in
                            single(.success(BaseEntity(statusCode: 0, message: alleryError.errorDescription)))
                            return Disposables.create()
                        }
                    })
                    .asObservable()
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
    
    }
    

}
