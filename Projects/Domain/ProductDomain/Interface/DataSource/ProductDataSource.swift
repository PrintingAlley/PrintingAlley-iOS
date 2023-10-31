//
//  ProductDataSource.swift
//  ProductDomainInterface
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol ProductDataSource {
    func fetchProduct(id: Int) -> Single<ProductEntity>
    func fetchProductList(page:Int, text: String, tegIds: [Int]) ->  Single<ProductListEntity>
    func createReview(id: Int) -> Single<BaseEntity>
    func editReview(id: Int, reviewId: Int, content: String, rating: Float, images: [String]) -> Single<BaseEntity>
    func deleteReview(id: Int, reviewId: Int) -> Single<BaseEntity>
}
