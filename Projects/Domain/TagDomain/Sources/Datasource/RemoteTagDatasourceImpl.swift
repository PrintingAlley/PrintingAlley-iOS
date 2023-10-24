//
//  RemoteTagDatasourceImpl.swift
//  TagDomain
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomain
import TagDomainInterface
import RxSwift
import BaseDomainInterface


final class RemoteTagDatasourceImpl: BaseRemoteDataSource<TagAPI>, RemoteTagDatasource {
    
    
    func fetchTag(id: Int) -> Single<ChildrenTagEntity> {
        request(.tag(id: id))
            .map(ChildrenTagResponseDTO.self)
            .map{$0.toDomain()}
    }
    
    func fetchHierarchy() -> Single<HierarchyEntity> {
        request(.hierarchy)
            .map(HierarchyResponseDTO.self)
            .map{$0.toDomain()}
    }
    

    

    

    

    
    
}
