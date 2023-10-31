//
//  TagRepositoryImpl.swift
//  TagDomain
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import TagDomainInterface
import RxSwift
import BaseDomainInterface

struct TagRepositoryImpl: TagRepository {

    

    
    private let remoteTagDatasource: any RemoteTagDatasource
    
    init(remoteTagDatasource: any RemoteTagDatasource) {
        self.remoteTagDatasource = remoteTagDatasource
    }
    

    func fetchTag(id: Int) -> Single<TagEntity> {
        remoteTagDatasource.fetchTag(id: id)
    }
    
    func fetchHierarchy() -> Single<HierarchyEntity> {
        remoteTagDatasource.fetchHierarchy()
    }
    
   

}
