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

public class BookMarkBottomSheetViewModel: ViewModelType {
     
    
    var id: Int! // 저장하려고 원하는 프로덕트 id
    
    let disposeBag = DisposeBag()
    
    var fetchMyBookMarksUseCase: any FetchMyBookMarksUseCase

    public struct Input {
        let fetchData: PublishSubject<Void> = .init()
    }
    
    public struct Output {
        var dataSource: BehaviorRelay<BookMarkGroupsEntity> = .init(value: BookMarkGroupsEntity.makeErrorEntity())
    }
    
    init(id: Int, fetchMyBookMarksUseCase: FetchMyBookMarksUseCase) {
        self.id = id
        self.fetchMyBookMarksUseCase = fetchMyBookMarksUseCase
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
        
    
        
        return output
    }
    
}
