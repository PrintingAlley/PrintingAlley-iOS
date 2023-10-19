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

struct TagRepositoryImpl: TagRepository {
    
    private let remoteTagDatasource: any RemoteTagDatasource
    
    init(remoteTagDatasource: any RemoteTagDatasource) {
        self.remoteTagDatasource = remoteTagDatasource
    }
    
    func fetchTagToplevel() -> Single<[TagToplevelEntity]> {
        remoteTagDatasource.fetchTagToplevel()
    }

}
