//
//  ProductRepositoryImpl.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import ProductDomainInterface
import BaseDomainInterface

public struct ProductRepositoryImpl: ProductRepository {

        
    private let remoteProductDataSource: any RemoteProductDataSource
    
    init(remoteProductDataSource: RemoteProductDataSource) {
        self.remoteProductDataSource = remoteProductDataSource
    }
    
    public func fetchProduct(id: Int) -> RxSwift.Single<BaseDomainInterface.ProductEntity> {
        remoteProductDataSource.fetchProduct(id: id)
    }
    
    public func fetchProductList(page: Int, text: String, tagIds: [Int]) -> RxSwift.Single<ProductDomainInterface.ProductListEntity> {
        
        remoteProductDataSource.fetchProductList(page: page, text: text, tagIds: tagIds)
    }
    
    public func createReview(id: Int,content: String, rating: Int, images: [String]) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        remoteProductDataSource.createReview(id: id,content: content, rating: rating, images: images)
    }
    
    public func editReview(id: Int, reviewId: Int, content: String, rating: Int, images: [String]) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        
        remoteProductDataSource.editReview(id: id, reviewId: reviewId, content: content, rating: rating, images: images)
    }
    
    public func deleteReview(id: Int, reviewId: Int) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        remoteProductDataSource.deleteReview(id: id, reviewId: reviewId)
    }
 
    
}
