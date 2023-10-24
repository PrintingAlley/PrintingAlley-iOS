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

public protocol HomeDependency: Dependency {
    var homeFactory: any HomeFactory { get }
    var searchFactory: any SearchFactory { get }
    var tagDomainFactory: any TagDomainFactory { get }
}

public final class HomeComponent: Component<HomeDependency>, HomeFactory {
    public func makeView() -> UIViewController {
        HomeViewController(viewModel: HomeViewModel(fetchTagUseCase: dependency.tagDomainFactory.fetchTagUseCase, fetchHierarchyUseCase: dependency.tagDomainFactory.fetchHierarchyUseCase), searchFactory: dependency.searchFactory)
    }
}
