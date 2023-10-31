//
//  RemoteSearchDatasourceImpl.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import BaseDomainInterface
import PrintShopDomainInterface
import RxSwift
import BaseDomainInterface

final class RemotePrintShopDataSourceImpl: BaseRemoteDataSource<PrintShopAPI>, RemotePrintShopDataSource {
    func fetchPrintShop(id: Int) -> RxSwift.Single<BaseDomainInterface.PrintShopEntity> {
        request(.one(id: id))
            .map(PrintShopResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func createReview(id: Int, content: String, rating: Int, images: [String]) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        request(.createReview(id: id, content: content, rating: rating, images: images))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
        
    }
    
    func editReview(id: Int, reviewId: Int, content: String, rating: Int, images: [String]) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        request(.editReview(id: id, reviewId: reviewId, content: content, rating: rating, images: images))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func deleteReview(id: Int, reviewId: Int) -> RxSwift.Single<BaseDomainInterface.BaseEntity> {
        request(.deleteReview(id: id, reviewId: reviewId))
            .map(BaseResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func fetchPrintShopList(page: Int, searchText: String) -> Single<PrintShopListEntity> {
        request(.list(page: page, searchText: searchText))
            .map(FetchPrintShopListResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func fetchPrintShopReview(id: Int) -> Single<PrintShopReviewEntity> {
        request(.fetchReview(id: id))
            .map(FetchPrintShopReviewResponseDTO.self)
            .map{$0.toDomain()}
    }
    
}
