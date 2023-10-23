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

final class RemoteTagDatasourceImpl: BaseRemoteDataSource<TagAPI>, RemoteTagDatasource {

    

    
    func fetchTagToplevel() -> Single<[TagToplevelEntity]> {
        request(.topLevel)
            .map([TagTopLevelResponseDTO].self)
            .map({$0.map{$0.toDomain()}})
        
    }
    
    func fetchHierarchy(id: Int) -> Single<HierarchyEntity> {
        request(.hierarchy(id: id))
            .map(HierarchyResponseDTO.self)
            .map{$0.toDomain()}
    }
    

    
    
}
