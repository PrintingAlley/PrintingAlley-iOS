//
//  SearchViewModel.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import RxRelay
import RxSwift
import BaseDomainInterface
import SearchDomainInterface

public class SearchViewModel: ViewModelType {
    
    var fetchPrintShopListUseCase: FetchPrintShopListUseCase!
    
    let disposeBag = DisposeBag()
    
    init(fetchPrintShopListUseCase: FetchPrintShopListUseCase) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
        self.fetchPrintShopListUseCase = fetchPrintShopListUseCase
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    public struct Input {
        let textString: BehaviorRelay<String> = BehaviorRelay(value: "")
    }
    
    public struct Output {
        let dataSource: PublishSubject<[PrintShopEntity]> = .init()
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        input.textString
            .distinctUntilChanged()
            .flatMapLatest { [unowned self] text in
                return self.fetchPrintShopListUseCase
                    .execute(searchText: text, tagIds: [])
                    .asObservable()
                    .catchError { error in
                        let alertError = error.asAlleyError
                        
                        return .just([PrintShopEntity(id: 0, name: "", address: "", phone: "", email: "", homepage: "", representative: "", introduction: "", logoImage: "", backgroundImage: "", latitude: "", longitude: "", tags: [])])
                    }
            }
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        print("\(output.dataSource)")
        
        return output
    }
}
