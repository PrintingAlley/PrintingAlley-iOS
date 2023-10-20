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
    
    var bookMarkGroupId: Int!
    var bookMarkGroupName: String = ""
    
    let disposeBag = DisposeBag()
    
    init(id: Int,bookMarkGroupName: String , fetchBookMarkDetailUseCase: FetchBookMarkDetailUseCase, removeBookMarkUseCase: RemoveBookMarkUseCase) {
        self.bookMarkGroupId = id
        self.bookMarkGroupName = bookMarkGroupName
        self.fetchBookMarkDetailUseCase = fetchBookMarkDetailUseCase
        self.removeBookMarkUseCase = removeBookMarkUseCase
    }
    
    public struct Input {
        let fetchDataSource: PublishSubject<Void> = .init()
    }
    
    public struct Output {
        let dataSource: BehaviorRelay<[SimplePrintShopInfoEntity]> = .init(value: [])
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        input.fetchDataSource
            .withUnretained(self){($0,$1)}
            .flatMap({ (owner,_) -> Observable<[SimplePrintShopInfoEntity]> in
                return owner.fetchBookMarkDetailUseCase
                        .execute(id: owner.bookMarkGroupId)
                        .catch({ error in
    
                            let alleryError = error.asAlleyError
                            DEBUG_LOG(alleryError.errorDescription)
                                return Single<[SimplePrintShopInfoEntity]>.create { single in
                                    single(.success([]))
                                    return Disposables.create()
                                }

                            
                        })
                        .asObservable()
            })
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
    
        
        
        return output
    }
    
    
 
    
}




