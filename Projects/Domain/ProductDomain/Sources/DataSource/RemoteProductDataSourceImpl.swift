//
//  RemoteProductDataSourceImpl.swift
//  ProductDomain
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import ProductDomainInterface
import RxSwift
import BaseDomainInterface

final class RemoteProductDataSourceImpl: BaseRemoteDataSource<ProductAPI>, RemoteProductDataSource {
    func fetchProduct(id: Int) -> Single<ProductEntity> {
        request(.fetchProduct(id: id))
            .map(ProductResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func fetchProductList(page: Int, text: String, tagIds tagIds: [Int]) -> Single<ProductListEntity> {
        request(.fetchProductList(page: page, text: text, tagIds: tagIds))
            .map(ProductListResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func createReview(id: Int,content: String, rating: Int, images: [String]) -> Single<BaseEntity> {
        request(.createReview(id: id, content: content, rating: rating, images: images))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func editReview(id: Int, reviewId: Int, content: String, rating: Int, images: [String]) -> Single<BaseEntity> {
        request(.editReview(id: id, reviewId: reviewId, content: content, rating: rating, images: images))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func deleteReview(id: Int, reviewId: Int) -> Single<BaseEntity> {
        request(.deleteReview(id: id, reviewId: reviewId))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func fetchReviews(id: Int) -> Single<[ProductReviewEntity]> {
        request(.fetchReview(id: id))
            .map([ProductReviewResponseDTO].self)
            .map{$0.map{$0.toDomain()}}
    }
    
}
