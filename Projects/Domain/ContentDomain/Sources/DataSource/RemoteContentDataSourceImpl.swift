//
//  RemoteContentDataSourceImpl.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ContentDomainInterface
import BaseDomain
import RxSwift

final class RemoteContentDataSourceImpl: BaseRemoteDataSource<ContentAPI>,RemoteContentDataSource {
    
    func fetchContents() -> Single<ContentGroupEntity>{
        request(.fetchContents)
            .map(ContentsResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    
}
