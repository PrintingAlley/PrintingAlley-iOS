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
import PrintShopDomainInterface

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
        let runIndicator: BehaviorRelay<Void> = .init(value: ())
        let dataSource: PublishSubject<[PrintShopEntity]> = .init()
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        input.textString
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] text in
                return self.fetchPrintShopListUseCase
                    .execute(page: 1, searchText: text)
                    .asObservable()
                    .catchError { error in
                        let alertError = error.asAlleyError
                        
                        return .just(PrintShopListEntity(printShops: [], statusCode: 0, message: ""))
                    }
            }
            .map{$0.printShops}
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        print("\(output.dataSource)")
        
        return output
    }
}
