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
import BaseDomainInterface

public final class BookMarkDetailViewModel: ViewModelType {
    
    
    var fetchBookMarkDetailUseCase: any FetchBookMarkDetailUseCase
    var removeBookMarkUseCase: any RemoveBookMarkUseCase
    
    var bookMarkGroupId: Int!
    var bookMarkGroupName: String = ""
    
    let disposeBag = DisposeBag()
    
    init(id: Int, bookMarkGroupName: String , fetchBookMarkDetailUseCase: FetchBookMarkDetailUseCase, removeBookMarkUseCase: RemoveBookMarkUseCase) {
        self.bookMarkGroupId = id
        self.bookMarkGroupName = bookMarkGroupName
        self.fetchBookMarkDetailUseCase = fetchBookMarkDetailUseCase
        self.removeBookMarkUseCase = removeBookMarkUseCase
    }
    deinit {
    
        DEBUG_LOG("\(Self.self) Denit ❌")
        
    }
    
    public struct Input {
        let fetchDataSource: PublishSubject<Void> = .init()
        let removePrintShop: PublishSubject<Int> = .init()
    }
    
    public struct Output {
        let dataSource: BehaviorRelay<[BookMarkDetailEntity]> = .init(value: [])
        let showToast: PublishRelay<BaseEntity> = .init()
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        input.fetchDataSource
            .withUnretained(self){($0,$1)}
            .flatMap({ (owner,_) -> Observable<[BookMarkDetailEntity]> in
                return owner.fetchBookMarkDetailUseCase
                        .execute(id: owner.bookMarkGroupId)
                        .catch({ error in
    
                            let alleryError = error.asAlleyError
                            DEBUG_LOG(alleryError.asAFError?.responseCode)
                                return Single<[BookMarkDetailEntity]>.create { single in
                                    single(.success([]))
                                    return Disposables.create()
                                }

                            
                        })
                        .asObservable()
            })
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
    
        
        input.removePrintShop
            .withUnretained(self)
            .flatMap({ (owner,id) -> Observable<BaseEntity> in
                
                return owner.removeBookMarkUseCase.execute(id: id)
                    .catch({ error in

                        let alleryError = error.asAlleyError
                        DEBUG_LOG(alleryError.asAFError?.responseCode)
                            return Single<BaseEntity>.create { single in
                                single(.success(BaseEntity(statusCode: 0, message: alleryError.errorDescription)))
                                return Disposables.create()
                            }

                        
                    })
                    .asObservable()
    
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
        
        
        return output
    }
    
    
 
    
}



