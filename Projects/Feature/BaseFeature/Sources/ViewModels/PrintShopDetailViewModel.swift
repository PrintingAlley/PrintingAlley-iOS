//
//  PrintShopDetailViewModel.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/13.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import RxSwift
import RxRelay
import BaseDomainInterface
import PrintShopDomainInterface

final class PrintShopDetailViewModel: ViewModelType {
    
    var id: Int!
    var fetchPrintShopUseCase: any FetchPrintShopUseCase
    
    let disposeBag = DisposeBag()
    
    init(id: Int, fetchPrintShopUseCase: FetchPrintShopUseCase) {
        self.id = id
        self.fetchPrintShopUseCase = fetchPrintShopUseCase
    }
    
    struct Input {
        
    }
    
    struct Output {
        let dataSource: BehaviorRelay<PrintShopEntity> = .init(value: .init(id: 0, name: "", address: "", phone: "", email: "", homepage: "", type: "", printType: "", afterProcess: "", businessHours: "", introduction: "", logoImage: "", backgroundImage: "", latitude: "", longitude: "", products: []))
        
        let images: BehaviorRelay<[String]> = .init(value: [])
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        fetchPrintShopUseCase.execute(id: id)
            .catch { error in
                let error = error.asAlleyError
                
                DEBUG_LOG(error.localizedDescription)
                
                return Single<PrintShopEntity>.create { single in
                    single(.success(PrintShopEntity.makeErrorEntity()))
                    return Disposables.create()
                }
            }
            .asObservable()
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        return output
    }
}
