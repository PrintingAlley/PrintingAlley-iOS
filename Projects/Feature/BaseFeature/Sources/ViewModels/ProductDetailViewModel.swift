//
//  ProductDetailViewModel.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import BaseDomainInterface
import RxSwift
import RxRelay
import ProductDomainInterface
import BookMarkDomainInterface

public struct ProductHeaderInfo {
    let id: Int
    let title: String
    let subtitle: String
    let images: [String]
}

struct ProductDataInfo {
    let dataSoruce: [String]
}

final class ProductDetailViewModel: ViewModelType {
    
    var id: Int!
    let disposeBag = DisposeBag()
    var fetchProductUseCase: any FetchProductUseCase
    var removeBookMarkUseCase: any RemoveBookMarkUseCase
    var isSaved: Bool = false
    var bookMarkId:Int = 0
    
    init(id: Int,fetchProductUseCase : FetchProductUseCase, removeBookMarkUseCase: RemoveBookMarkUseCase) {
        self.id = id
        self.fetchProductUseCase = fetchProductUseCase
        self.removeBookMarkUseCase = removeBookMarkUseCase
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    struct Input {
        let askToast: PublishSubject<BaseEntity> = .init()
        let fetchData: PublishSubject<Void> = .init()
        let removeItem: PublishSubject<Void> = .init()
    }
    
    struct Output {
        let showToast: PublishSubject<BaseEntity> = .init()
        let headerInfo: BehaviorRelay<ProductHeaderInfo> = .init(value:  ProductHeaderInfo(id: 0, title: "", subtitle: "", images: []))
        let dataInfo: BehaviorRelay<ProductDataInfo> = .init(value: ProductDataInfo(dataSoruce: []))
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.askToast
            .bind(to:output.showToast)
            .disposed(by: disposeBag)
        
        input.fetchData
            .flatMap({ [weak self] _ -> Observable<ProductDetailEntity> in
                
                guard let  self else {return Observable.empty()}
                
                return self.fetchProductUseCase
                    .execute(id: id)
                    .catch({ error in
                        DEBUG_LOG(error)
                        
                        return Single<ProductDetailEntity>.create { single in
                            single(.success(ProductDetailEntity.makeErrorEntity()))
                            return Disposables.create()
                        }
                    })
                    .asObservable()
            })
            .do(onNext: { [weak self] dataSource in
                
                guard let self else { return }
                
                if dataSource.statusCode == 400 {
                    input.askToast.onNext(BaseEntity(statusCode: 0, message: "알 수 없는 에러가 발생했습니다."))
                }
                else {
                    self.bookMarkId = dataSource.bookmarkId
                }
            })
            .map({$0.product})
            .subscribe(onNext: { [weak self] dataSource in
                
                guard let self else {return}
                
                self.isSaved = dataSource.isBookmarked
                
                
                output.headerInfo.accept(ProductHeaderInfo(id: dataSource.id, title: dataSource.name, subtitle: dataSource.category.name , images: dataSource.images))
                output.dataInfo.accept(ProductDataInfo(dataSoruce: [dataSource.printShop.name, dataSource.designer,dataSource.size, dataSource.paper, dataSource.tags.map{$0.name}.joined(separator: ", "), dataSource.afterProcess]))
            })
            .disposed(by: disposeBag)
        
        
        
        input.removeItem
            .withUnretained(self)
            .flatMap({ (owner,_) -> Observable<BaseEntity> in
                
                return owner.removeBookMarkUseCase
                    .execute(id: owner.bookMarkId)
                    .catchAndReturn(BaseEntity(statusCode: 400, message: "페이지를 나갔다 들어와주세요."))
                    .map{ $0.statusCode != 400 ? BaseEntity(statusCode: 200, message: "성공적으로 삭제했습니다.") : $0 }
                    .asObservable()
            
            })
            .do(onNext: { [weak self] in
                
                guard let self else {return}
                
                if $0.statusCode == 200 {
                    self.isSaved = false
                }
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
            
        
        return output
    }
}
