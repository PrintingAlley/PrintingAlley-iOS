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
        let dataSource: BehaviorRelay<[PrintShopEntity]> = .init(value: [])
        var canLoadMore: BehaviorRelay<Bool> = .init(value: true)
    }
    
    public func transform(input: Input) -> Output {
        let output = Output()
        
        let refresh = Observable.combineLatest(output.dataSource, input.pageID) { (dataSource, pageID) -> [PrintShopEntity] in
            return pageID == 1 ? [] : dataSource
        }
        
        input.loadMore
            .withLatestFrom(input.pageID) // loadMore가 갱신될 때마다 pageID와 함께 내뱉음
            .subscribe(onNext: { // loadMore가 갱신되면 pageID를 += 1
                input.pageID.accept($0+1)
        })
        .disposed(by: disposeBag)
        
//        input.textString // textMore가 갱신될 때마다 내뱉음.............. -> textMore과 pageID가 함께 갱신을 체크해줘야함....
//        Observable.combineLatest(input.textString.distinctUntilChanged(), input.pageID.distinctUntilChanged())
//            .distinctUntilChanged()
        input.pageID
            .withLatestFrom(input.textString.distinctUntilChanged()){ ($1, $0) }
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { [weak self] (text, pageID) -> Observable<PrintShopListEntity> in
                guard let self else { return Observable.empty() }
                
                return self.fetchPrintShopListUseCase
                    .execute(page: pageID, searchText: text)
                    .catchError { error in
                        
                        print("WWW4 \(error.localizedDescription)")
                        let alleyError = error.asAlleyError
                        
                        return Single<PrintShopListEntity>.create { single in
                            single(.success(PrintShopListEntity(printShops: [], statusCode: 0, message: alleyError.errorDescription ?? "")))
                            return Disposables.create()
                        }
                    }
                    .asObservable()
            }
            .debug("WWW4")
            .map{ $0.printShops }
            .do(onNext: { (model) in
                output.canLoadMore.accept(!model.isEmpty)
            }, onError: { _ in
                output.canLoadMore.accept(false)
            }) // withLatestFrom 으로 안 넘어감 그래서 bind 가 안됨
            .withLatestFrom(refresh, resultSelector: { (newModels, datasources) -> [PrintShopEntity] in
                
                return datasources + newModels
            })
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        return output
    }
}
