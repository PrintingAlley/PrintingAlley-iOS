//
//  SearchDomainComponent.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import PrintShopDomainInterface
import JwtStoreInterface

public protocol PrintShopDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
}

public final class PrintShopDomainComponent: Component<PrintShopDomainDependency>, PrintShopDomainFactory {
    public var fetchPrintShopUseCase: any FetchPrintShopUseCase {
        FetchPrintShopUseCaseImpl(printShopRepository: printShopRepository)
    }
    
    public var createReviewUseCase:  any CreateReviewUseCase {
        CreateReviewUseCaseImpl(printShopRepository: printShopRepository)
    }
    
    public var editReviewUseCase: any EditReviewUseCase {
        EditReviewUseCaseImpl(printShopRepository: printShopRepository)
    }
    
    public var deleteReviewUseCase: any DeleteReviewUseCase {
        DeleteReviewUseCaseImpl(printShopRepository: printShopRepository)
    }
    
     public var fetchPrintShopListUseCase: any FetchPrintShopListUseCase {
         FetchPrintShopListUseCaseImpl(printShopRepository: printShopRepository)
     }
    
    public var fetchPrintShopReviewUseCase: any FetchPrintShopReviewUseCase {
        FetchPrintShopReviewUseCaseImpl(printShopRepository: printShopRepository)
    }
     
     public var printShopRepository: any PrintShopRepository {
         PrintShopRepositoryImpl(remotePrintShopDataSource: remotePrintShopDataSource)
     }
     
     public var remotePrintShopDataSource: any RemotePrintShopDataSource {
         RemotePrintShopDataSourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
     }
    
 }
