//
//  SearchDomainFactory.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public protocol PrintShopDomainFactory {
    var fetchPrintShopListUseCase: any FetchPrintShopListUseCase { get }
    
    var fetchPrintShopUseCase: any FetchPrintShopUseCase { get }
    
    var createReviewUseCase: any CreateReviewUseCase { get }
    
    var editReviewUseCase: any EditReviewUseCase { get }
    
    var deleteReviewUseCase: any DeleteReviewUseCase { get }
    
}
