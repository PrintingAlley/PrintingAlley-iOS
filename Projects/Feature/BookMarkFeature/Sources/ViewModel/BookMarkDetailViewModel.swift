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
    
    let disposeBag = DisposeBag()
    
    init(id: Int,fetchBookMarkDetailUseCase: FetchBookMarkDetailUseCase, removeBookMarkUseCase: RemoveBookMarkUseCase) {
        self.bookMarkGroupId = id
        self.fetchBookMarkDetailUseCase = fetchBookMarkDetailUseCase
        self.removeBookMarkUseCase = removeBookMarkUseCase
        
        DEBUG_LOG("\(Self.self) Init ✅")
    }
    deinit {
    
        DEBUG_LOG("\(Self.self) Denit ❌")
        
    }
    
    public struct Input {
        let fetchDataSource: PublishSubject<Void> = .init()
        let removeBookMark: PublishSubject<Int> = .init()
    }
    
    public struct Output {
        let dataSource: BehaviorRelay<BookMarkGroupEntity> = .init(value: BookMarkGroupEntity(id: 0, name: "", bookmarks: []))
        let showToast: PublishRelay<BaseEntity> = .init()
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        input.fetchDataSource
            .withUnretained(self){($0,$1)}
            .flatMap({ (owner,_) -> Observable<BookMarkGroupWrapperEntity> in
                  
                return owner.fetchBookMarkDetailUseCase
                        .execute(id: owner.bookMarkGroupId)
                        .catch({ error in
                                DEBUG_LOG("EEROR: \(error)")
                            let alleryError = error.asAlleyError
                                return Single<BookMarkGroupWrapperEntity>.create { single in
                                    single(.success(BookMarkGroupWrapperEntity(bookmarkGroup: BookMarkGroupEntity(id: 0, name: "", bookmarks: []), statusCode: 0, message: alleryError.errorDescription ?? "")))
                                    return Disposables.create()
                                }

                            
                        })
                        .asObservable()
            })
            .map{$0.bookmarkGroup}
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
    
        
        input.removeBookMark
            .withUnretained(self)
            .flatMap({ (owner,id) -> Observable<BaseEntity> in
                
                return owner.removeBookMarkUseCase.execute(id: id)
                    .catch({ error in

                        let alleryError = error.asAlleyError
                        DEBUG_LOG(alleryError.asAFError?.responseCode)
                            return Single<BaseEntity>.create { single in
                                single(.success(BaseEntity(statusCode: 0, message: alleryError.errorDescription!)))
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




