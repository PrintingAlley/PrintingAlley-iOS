//
//  ProductDomainComponent.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import ProductDomainInterface
import JwtStoreInterface

public protocol ProductDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
}

public final class ProductDomainComponent: Component<ProductDomainDependency>, ProductDomainFactory {
    public var fetchProductUseCase: any FetchProductUseCase {
        FetchProductUseCaseImpl(productRepository: productRepository)
    }
    
    public var fetchProductListUseCase: any FetchProductListUseCase {
        FetchProductListUseCaseImpl(productRepository: productRepository)
    }
    
    public var createReviewUseCase: any CreateReviewUseCase {
        CreateReviewUseCaseImpl(productRepository: productRepository)
    }
    
    public var editReviewUseCase: any EditReviewUseCase {
        EditReviewUseCaseImpl(productRepository: productRepository)
    }
    
    public var deleteReviewUseCase: any DeleteReviewUseCase {
        DeleteReviewUseCaseImpl(productRepository: productRepository)
    }
    
    public var fetchProductReviewUseCase: any FetchProductReviewUseCase {
        FetchProductReviewUseCaseImpl(productRepository: productRepository)
    }
    
    
    public var remoteProductDataSource: any RemoteProductDataSource {
        RemoteProductDataSourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    }
    
    public var productRepository: any ProductRepository {
        ProductRepositoryImpl(remoteProductDataSource: remoteProductDataSource)
    }
    

    
 }
