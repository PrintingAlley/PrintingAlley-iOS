//
//  SearchComponent.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import UIKit
import SearchFeatueInterface

public protocol SearchDependency: Dependency {
    var searchFactory: any SearchFactory { get }
}

public final class SearchComponent: Component<SearchDependency>, SearchFactory {
    public func makeView() -> UIViewController {
        SearchViewController()
    }
}
