//
//  SearchRepository.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import BaseDomainInterface

public protocol PrintShopRepository {
    func fetchPrintShopList(page:Int, searchText: String) -> Single<PrintShopListEntity>
    func fetchPrintShop(id: Int) -> Single<PrintShopEntity>
    
    func createReview(id:Int, content: String, rating: Int, images: [String]) -> Single<BaseEntity>
    
    func editReview(id:Int,reviewId: Int, content: String, rating: Int, images: [String]) -> Single<BaseEntity>
    
    func deleteReview(id:Int,reviewId: Int) -> Single<BaseEntity>
    
    func fetchPrintShopReview(id: Int) -> Single<PrintShopReviewEntity>
}
