//
//  HomeViewModel.swift
//  HomeFeatureInterface
//
//  Created by 박의서 on 2023/10/11.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import TagDomainInterface
import RxRelay
import RxSwift

final class HomeViewModel: ViewModelType {
    
    var fetchTagToplevelUseCase: any FetchTagToplevelUseCase
    
    let disposeBag = DisposeBag()
    
    init(fetchTagToplevelUseCase: FetchTagToplevelUseCase) {
        self.fetchTagToplevelUseCase = fetchTagToplevelUseCase
    }
    
    public struct Input {
        let viewDidLoad: PublishSubject<Void> = .init()
    }
    
    public struct Output{
        let tagDataSource: BehaviorRelay<[TagToplevelEntity]> = .init(value: [])
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoad
            .flatMap({ [weak self] () -> Observable<[TagToplevelEntity]> in
                
                guard let self else { return Observable.empty()}
                
                return self.fetchTagToplevelUseCase.execute()
                    .asObservable()
                
            })
            .bind(to: output.tagDataSource)
            .disposed(by: disposeBag)
        
        return output
    }
}
