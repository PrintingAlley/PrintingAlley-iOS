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
    }
    
    init(id: Int, fetchMyBookMarksUseCase: FetchMyBookMarksUseCase, addBookMarkUseCase: AddBookMarkUseCase) {
        self.id = id
        self.fetchMyBookMarksUseCase = fetchMyBookMarksUseCase
        self.addBookMarkUseCase = addBookMarkUseCase
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.fetchData
            .flatMap{ [weak self] _  -> Observable<BookMarkGroupsEntity> in
                    
                guard let self else {return Observable.empty()}
                
                return self.fetchMyBookMarksUseCase
                    .execute()
                    .catchAndReturn(BookMarkGroupsEntity.makeErrorEntity())
                    .asObservable()
            
            }
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        
        input.selectedItem
            .withUnretained(self)
            .flatMap({(owner,groupId) -> Observable<BaseEntity> in
                
                return owner.addBookMarkUseCase
                    .execute(productId: owner.id, bookmarkGroupId: groupId)
                    .catchAndReturn(BaseEntity(statusCode: 400, message: ""))
                    .asObservable()
                
            })
            .bind(to: output.result)
            .disposed(by: disposeBag)
    
        
        
        return output
    }
    
}
