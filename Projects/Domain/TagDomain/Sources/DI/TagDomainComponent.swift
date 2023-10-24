//
//  TagDomainComponent.swift
//  TagDomain
//
//  Created by 박의서 on 2023/10/19.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import TagDomainInterface
import JwtStoreInterface

public protocol TagDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
} // jwt 가 존재하는 곳. dependency에서 주입받음

public final class TagDomainComponent: Component<TagDomainDependency>, TagDomainFactory {
    public var fetchTagUseCase: any FetchTagUseCase {
        FetchTagUseCaseImpl(tagRepository: tagRepository)
    } // 레포지토리를 주입받음
    
    public var fetchHierarchyUseCase: any FetchHierarchyUseCase {
        FetchHierarchyUseCaseImpl(tagRepository: tagRepository)
    }
    
    public var tagRepository: any TagRepository {
        TagRepositoryImpl(remoteTagDatasource: remoteTagDatasource)
    } // 데이터소스를 주입받음
    
    public var remoteTagDatasource: any RemoteTagDatasource {
        RemoteTagDatasourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
    } // jwt를 주입받음. 완성받아 repository로
}
