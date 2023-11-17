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
        var pageID: PublishRelay<(Int)> = .init()
        var loadMore: PublishSubject<Void> = .init()
    }
    
    public struct Output {
        let runIndicator: BehaviorRelay<Void> = .init(value: ())
        let dataSource: PublishSubject<[PrintShopEntity]> = .init()
        var canLoadMore: BehaviorRelay<Bool> = .init(value: true)
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        let refresh = Observable.combineLatest(output.dataSource, input.pageID) { (dataSource, pageID) -> [PrintShopEntity] in
            return pageID == 1 ? [] : dataSource
        }
        
        input.loadMore
            .withLatestFrom(input.pageID)
            .subscribe(onNext: {
                input.pageID.accept($0+1)
        })
        .disposed(by: disposeBag)
        
        input.textString
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.pageID){ ($0, $1) }
            .flatMap { [weak self] (text, page) -> Observable<PrintShopListEntity> in
                guard let self else { return Observable.empty() }
                
                return self.fetchPrintShopListUseCase
                    .execute(page: input.pageID, searchText: text)
                    .catchError { error in
                        
                        print("WWW4 \(error.localizedDescription)")
                        let alleyError = error.asAlleyError
                        
                        return Single<PrintShopListEntity>.create { single in
                            single(.success(PrintShopListEntity(printShops: [], statusCode: 0, message: alleyError.errorDescription)))
                            return Disposables.create()
                        }
                    }
                    .asObservable()
            }
            .debug("WWW4")
            .map{$0.printShops}
            .do(onNext: { (model) in
                output.canLoadMore.accept(!model.isEmpty)
            }, onError: { _ in
                output.canLoadMore.accept(false)
            })
            .withLatestFrom(refresh, resultSelector: { (newModels, datasources) -> [PrintShopEntity] in
                return datasources + newModels
            })
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        print("\(output.dataSource)")
        
        return output
    }
}
