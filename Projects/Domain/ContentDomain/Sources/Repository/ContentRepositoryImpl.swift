//
//  ContentRepositoryImpl.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import ContentDomainInterface
import RxSwift

struct ContentRepositoryImpl: ContentRepository {

        
    var remoteContentDataSource: any RemoteContentDataSource
    
    init(remoteContentDataSource: any RemoteContentDataSource) {
        self.remoteContentDataSource = remoteContentDataSource
    }
    
    
    
    func fetchContents() -> Single<ContentGroupEntity> {
        remoteContentDataSource.fetchContents()
    }
    

}
