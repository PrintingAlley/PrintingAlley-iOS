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
import BookMarkDomainInterface
import BaseDomainInterface

public class BookMarkBottomSheetViewModel: ViewModelType {
     
    
    var id: Int! // 저장하려고 원하는 프로덕트 id
    
    let disposeBag = DisposeBag()
    
    var fetchMyBookMarksUseCase: any FetchMyBookMarksUseCase
    var addBookMarkUseCase : any AddBookMarkUseCase

    
    
    
    public struct Input {
        let fetchData: PublishSubject<Void> = .init()
        let selectedItem: PublishSubject<Int> = .init()
    }
    
    public struct Output {
        var dataSource: BehaviorRelay<BookMarkGroupsEntity> = .init(value: BookMarkGroupsEntity.makeErrorEntity())
        let result: PublishSubject<BaseEntity> = .init()
        let addResult: PublishSubject<AddBookMarkEntity> = .init()
    }
    
    init(id: Int, fetchMyBookMarksUseCase: FetchMyBookMarksUseCase, addBookMarkUseCase: AddBookMarkUseCase) {
        self.id = id
        self.fetchMyBookMarksUseCase = fetchMyBookMarksUseCase
        self.addBookMarkUseCase = addBookMarkUseCase
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.fetchData
            .flatMap{ [weak self] _  -> Observable<BookMarkGroupsEntity> in
                    
                guard let self else {return Observable.empty()}
                
                return self.fetchMyBookMarksUseCase
                    .execute()
                    .catch({ error in
                        
                        let alleyError = error.asAlleyError
                        
                        if alleyError == .tokenExpired {
                             return Single.create { single in
                                
                                 single(.success(BookMarkGroupsEntity(bookmarkGroups: [], statusCode: 401, message: alleyError.errorDescription ?? "")))
                                 return Disposables.create()
                            }
                        }
                        
                        return Single.create { single in
                           
                            single(.success(BookMarkGroupsEntity(bookmarkGroups: [], statusCode: 400, message: alleyError.errorDescription ?? "")))
                            return Disposables.create()
                       }
                        
                    })
                    .asObservable()
            
            }
            .do(onNext: {
                
                if $0.statusCode == 400 || $0.statusCode == 401 {
                    output.result.onNext((BaseEntity(statusCode: $0.statusCode, message: $0.message)))
                }
                
                else {
                    output.result.onNext((BaseEntity(statusCode: $0.statusCode, message: $0.message)))
                }
                
            })
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        
        input.selectedItem
            .withLatestFrom(output.dataSource){($0,$1)}
            .flatMap({ [weak self] (index,dataSource) -> Observable<AddBookMarkEntity> in
                
                guard let self else {return Observable.empty()}
                
        
                return self.addBookMarkUseCase
                    .execute(productId: self.id, bookmarkGroupId: dataSource.bookmarkGroups[index].id)
                    .catchAndReturn(AddBookMarkEntity(statusCode: 400, message: "", dataId: 0))
                    .asObservable()
                
            })
            .bind(to: output.addResult)
            .disposed(by: disposeBag)
    
        
        
        return output
    }
    
}
