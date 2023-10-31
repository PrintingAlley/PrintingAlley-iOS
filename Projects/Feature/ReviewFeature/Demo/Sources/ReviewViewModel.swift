//
//  ReviewViewModel.swift
//  ReviewFeatureDemo
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import RxSwift
import RxRelay


class ReviewViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    
    var testDS: TestDataSourceImpl
    
    init(testDS:  TestDataSourceImpl) {
        self.testDS = testDS
    }
    
    struct Input {
        let dataSource: PublishSubject<Data> = .init()
        let tapSend: PublishSubject<Void> = .init()
    }
    
    struct Output {
        let dataSource: PublishRelay<Data> = .init()
        let result: PublishSubject<String> = .init()
    }
    
    
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.dataSource
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        
        input.tapSend
            .withLatestFrom(output.dataSource)
            .flatMap{[weak self]  dataSource -> Observable<TmpEntity> in
                
                guard let self else {return Observable.empty()}
                
                return self.testDS.upload(data: dataSource)
                    .asObservable()
            }
            .map{$0.url}
            .bind(to: output.result)
            .disposed(by: disposeBag)
        
        return output
    }
    
}
