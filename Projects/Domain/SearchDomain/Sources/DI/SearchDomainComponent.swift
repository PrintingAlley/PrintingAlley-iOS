//
//  SearchDomainComponent.swift
//  SearchDomainInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import SearchDomainInterface
import JwtStoreInterface

public protocol SearchDomainDependency: Dependency {
    var jwtStoreFactory: any JwtStoreFactory { get }
}

public final class SearchDomainComponent: Component<SearchDomainDependency>, SearchDomainFactory {
     public var fetchPrintShopListUseCase: any FetchPrintShopListUseCase {
         FetchPrintShopListUseCaseImpl(searchRepository: searchRepository)
     }
     
     public var searchRepository: any SearchRepository {
         SearchRepositoryImpl(remoteSearchDatasource: remoteSearchDatasource)
     }
     
     public var remoteSearchDatasource: any RemoteSearchDatasource {
         RemoteSearchDatasourceImpl(jwtStore: dependency.jwtStoreFactory.jwtStore)
     }
 }
