//
//  ContentComponent.swift
//  ContentDomain
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import NeedleFoundation
import ContentDomainInterface
import JwtStoreInterface

public protocol ContentDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
}

public final class ContentDomainComponent: Component<ContentDomainDependency>, ContentDomainFactory {
    public var fetchContentsUseCase: any FetchContentsUseCase {
        FetchContentsUseCaseImpl(contentRepository: contentRepository)
    }
    
    
    var remoteContentDataSource: any RemoteContentDataSource {
        RemoteContentDataSourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    }
    

    public var contentRepository: any ContentRepository {
        ContentRepositoryImpl(remoteContentDataSource: remoteContentDataSource)
    }
    
    
}
