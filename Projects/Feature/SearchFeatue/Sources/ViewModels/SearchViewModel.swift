//
//  SearchViewModel.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import SearchDomainInterface
import RxRelay
import RxSwift

public class SearchViewModel: ViewModelType {
    
    var fetchPrintShopListUseCase: any FetchPrintShopListUseCase
    
    let disposeBag = DisposeBag()
    
    init(fetchPrintShopListUseCase: any FetchPrintShopListUseCase) {
        self.fetchPrintShopListUseCase = fetchPrintShopListUseCase
    }
    
    public struct Input {
        let viewDidLoad: PublishSubject<Void> = .init() // 수정?
    }
    
    public struct Output {
        let searchDataSource: BehaviorRelay<[PrintShopListEntity]> = .init(value: [])
    }

    public func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoad
            .flatMap({ [weak self] () -> Observable<[PrintShopListEntity]> in
                
                guard let self else { return Observable.empty() }
                
                return self.fetchPrintShopListUseCase.execute(searchText: "", tagIds: [0]).asObservable() // 수정
                
            })
            .bind(to: output.searchDataSource)
            .disposed(by: disposeBag)
        
        return output
    }
}
