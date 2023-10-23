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
import UserDomainInterface

public class EditModalViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    var type: EditType!
    var generateBookMarkUseCase: any GenerateBookMarkUseCase
    var renameBookMarkGroupUseCase: any RenameBookMarkGroupUseCase
    var renameUserUseCase: any RenameUserUseCase
    
    var id: Int = -1
    //TODO: 프로필 이름 변경 유즈 케이스
    
    init(id:Int = -1, type: EditType!, generateBookMarkUseCase: GenerateBookMarkUseCase,renameBookMarkGroupUseCase: RenameBookMarkGroupUseCase, renameUserUseCase: RenameUserUseCase) {
        self.id = id
        self.type = type
        self.generateBookMarkUseCase = generateBookMarkUseCase
        self.renameBookMarkGroupUseCase = renameBookMarkGroupUseCase
        self.renameUserUseCase = renameUserUseCase
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    public struct Input {
        let tapConfirm: PublishSubject<Void> = .init()
        let text:BehaviorRelay<String> = .init(value: "")
    }
    
    public struct Output {
        let showToast: PublishSubject<BaseEntity> = .init()
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
                
                    
                switch self.type {
                
                case .newBookMark:
                    return self.generateBookMarkUseCase.execute(name: text)
                        .catch({ error in
                            
                            let alleryError = error.asAlleyError
                            
                            if alleryError == .tokenExpired {
                                return Single<BaseEntity>.create { single in
                                    single(.success(BaseEntity(statusCode: 401, message: alleryError.errorDescription ?? "")))
                                    return Disposables.create()
                                }
                            }
                            
                            return Single<BaseEntity>.create { single in
                                single(.success(BaseEntity(statusCode: 0, message: alleryError.errorDescription)))
                                return Disposables.create()
                            }
                        })
                        .asObservable()
                    
                case .reNameBookMark:
                    return self.renameBookMarkGroupUseCase.execute(id: self.id, name: text)
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
                    
                case .reNameprofileName:
                    return self.renameUserUseCase.execute(name: text)
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
                    
                    
                    
                default:
                    return Single<BaseEntity>.create { single in
                        single(.success(BaseEntity(statusCode: 401, message: "")))
                        return Disposables.create()
                    }
                    .asObservable()
                    
                }
                
                
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
    
    }
    

}
