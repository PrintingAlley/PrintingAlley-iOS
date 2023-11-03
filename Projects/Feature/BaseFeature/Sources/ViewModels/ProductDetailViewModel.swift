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
    
    init(id: Int,fetchProductUseCase : FetchProductUseCase, removeBookMarkUseCase: RemoveBookMarkUseCase) {
        self.id = id
        self.fetchProductUseCase = fetchProductUseCase
        self.removeBookMarkUseCase = removeBookMarkUseCase
    }
    
    struct Input {
        let askToast: PublishSubject<BaseEntity> = .init()
        let fetchData: PublishSubject<Void> = .init()
        let removeItem: PublishSubject<Int> = .init()
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
            .flatMap({ [weak self] _ -> Observable<ProductEntity> in
                
                guard let  self else {return Observable.empty()}
                
                return self.fetchProductUseCase
                    .execute(id: id)
                    .catchAndReturn(ProductEntity.makeErrorEntity(message: ""))
                    .asObservable()
            })
            .do(onNext: {
                if $0.statusCode == 400 {
                    input.askToast.onNext(BaseEntity(statusCode: 0, message: "알 수 없는 에러가 발생했습니다."))
                }
            })
            .subscribe(onNext: { [weak self] dataSource in
                
                guard let self else {return}
                
                self.isSaved = dataSource.isBookmarked
                
                output.headerInfo.accept(ProductHeaderInfo(id: dataSource.id, title: dataSource.name, subtitle: dataSource.category.name , images: dataSource.images))
                output.dataInfo.accept(ProductDataInfo(dataSoruce: [dataSource.printShop.name,dataSource.designer,dataSource.size, dataSource.paper, dataSource.tags.map{$0.name}.joined(separator: ", "), dataSource.afterProcess]))
            })
            .disposed(by: disposeBag)
        
        
        
        input.removeItem
            .withUnretained(self)
            .flatMap({ (owner,id) -> Observable<BaseEntity> in
                
                owner.removeBookMarkUseCase
                    .execute(id: id)
                    .catchAndReturn(BaseEntity(statusCode: 400, message: "알 수 없는 에러가 발생했습니다."))
                    .map{ $0.statusCode != 400 ? BaseEntity(statusCode: 200, message: "성공적으로 삭제했습니다.") : $0 }
                    .asObservable()
            
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
            
        
        return output
    }
}
