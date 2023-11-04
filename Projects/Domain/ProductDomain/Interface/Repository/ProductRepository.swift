//
//  ProductRepository.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol ProductRepository {
    func fetchProduct(id: Int) -> Single<ProductDetailEntity>
    func fetchProductList(page:Int, text: String, tagIds: [Int]) ->  Single<ProductListEntity>
    func createReview(id: Int,content: String, rating: Int, images: [String]) -> Single<BaseEntity>
    func editReview(id: Int, reviewId: Int, content: String, rating: Int, images: [String])-> Single<BaseEntity>
    func deleteReview(id: Int, reviewId: Int) -> Single<BaseEntity>
    func fetchReviews(id: Int) -> Single<[ProductReviewEntity]>
}
