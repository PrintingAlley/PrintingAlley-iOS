//
//  HomeComponent.swift
//  HomeFeatureInterface
//
//  Created by 박의서 on 2023/10/11.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import UIKit
import HomeFeatureInterface
import SearchFeatueInterface
import TagDomainInterface
import CategorySearchFeatureInterface
import ContentDomainInterface

public protocol HomeDependency: Dependency {
    var homeFactory: any HomeFactory { get }
    var searchFactory: any SearchFactory { get }
    var tagDomainFactory: any TagDomainFactory { get }
    var categorySearchFactory: any CategorySearchFactory { get }
    var contentDomainFactory: any ContentDomainFactory { get }
    
}

public final class HomeComponent: Component<HomeDependency>, HomeFactory {
    public func makeView() -> UIViewController {
        HomeViewController(viewModel: HomeViewModel(fetchHierarchyUseCase: dependency.tagDomainFactory.fetchHierarchyUseCase, fetchContentsUseCase: dependency.contentDomainFactory.fetchContentsUseCase), searchFactory: dependency.searchFactory, categorySearchFactory: dependency.categorySearchFactory)
    }
}
