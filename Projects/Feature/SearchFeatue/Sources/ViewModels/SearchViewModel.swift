//
//  SearchViewModel.swift
//  SearchFeatueInterface
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
    
//    var fetchPrintShopListUseCase: any FetchPrintShopListUseCase
    
    let disposeBag = DisposeBag()
    
//    init(fetchPrintShopListUseCase: any FetchPrintShopListUseCase) {
//        self.fetchPrintShopListUseCase = fetchPrintShopListUseCase
//    }
    
    public struct Input {
        let textString: BehaviorRelay<String> = BehaviorRelay(value: "")
    }
    
    public struct Output {
        var dataSource: BehaviorRelay<[PrintShopEntity]> = .init(value: [])
    }

    public func transform(input: Input) -> Output {
        let output = Output()

//        input.viewDidLoad
//            .flatMap({ [weak self] () -> Observable<[PrintShopListEntity]> in
//
//                guard let self else { return Observable.empty() }
//
//                return self.fetchPrintShopListUseCase.execute(searchText: "인쇄", tagIds: [0])
//                    .debug("인쇄소 목록")
//                    .catch({ error in
//                        let alleyError = error.asAlleyError
//
//                        return Single<PrintShopListEntity>.create { single in
//                            single(.success(PrintShopListEntity(id: 0, image: "", name: "", tags: [], introduction: "", address: "")))
//                            return Disposables.create()
//                        }
//                    })
//                        .asObservable()
//
//            })
//            .bind(to: output.dataSource)
//            .disposed(by: disposeBag)

        return output
    }
}
