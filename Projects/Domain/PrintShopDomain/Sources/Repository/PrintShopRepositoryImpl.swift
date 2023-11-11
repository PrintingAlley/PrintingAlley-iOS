//
//  SearchRepositoryImpl.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import PrintShopDomainInterface
import BaseDomainInterface
import RxSwift
import BaseDomainInterface

struct PrintShopRepositoryImpl: PrintShopRepository {

        
    private let remotePrintShopDataSource: any RemotePrintShopDataSource
    
    init(remotePrintShopDataSource: any RemotePrintShopDataSource) {
        self.remotePrintShopDataSource = remotePrintShopDataSource
    }
    
    func fetchPrintShopList(page: Int, searchText: String) -> Single<PrintShopListEntity> {
        remotePrintShopDataSource.fetchPrintShopList(page: page, searchText: searchText)
    }
    
    
    func fetchPrintShop(id: Int) -> RxSwift.Single<BaseDomainInterface.PrintShopEntity> {
        remotePrintShopDataSource.fetchPrintShop(id: id)
    }
    
    func createReview(id: Int, content: String, rating: Int, images: [String]) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        remotePrintShopDataSource.createReview(id: id, content: content, rating: rating, images: images)
    }
    
    func editReview(id: Int, reviewId: Int, content: String, rating: Int, images: [String]) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        remotePrintShopDataSource.editReview(id: id, reviewId: reviewId, content: content, rating: rating, images: images)
    }
    
    func deleteReview(id: Int, reviewId: Int) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        
        
        remotePrintShopDataSource.deleteReview(id: id, reviewId: reviewId)
    }
    
    func fetchPrintShopReview(id: Int) -> Single<PrintShopReviewEntity> {
        remotePrintShopDataSource.fetchPrintShopReview(id: id)
    }
}
