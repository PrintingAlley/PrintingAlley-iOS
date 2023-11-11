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
import TagDomainInterface
import CategorySearchFeatureInterface
import ContentDomainInterface
import BaseFeatureInterface

public protocol HomeDependency: Dependency {
    var homeFactory: any HomeFactory { get }
    var tagDomainFactory: any TagDomainFactory { get }
    var categorySearchFactory: any CategorySearchFactory { get }
    var contentDomainFactory: any ContentDomainFactory { get }
    var webViewFactory: any WebViewFactory { get }
    
}

public final class HomeComponent: Component<HomeDependency>, HomeFactory {
    public func makeView() -> UIViewController {
        HomeViewController(viewModel: HomeViewModel(fetchHierarchyUseCase: dependency.tagDomainFactory.fetchHierarchyUseCase, fetchContentsUseCase: dependency.contentDomainFactory.fetchContentsUseCase), categorySearchFactory: dependency.categorySearchFactory, webviewFacotry: dependency.webViewFactory)
    }
}
