//
//  WebViewComponent.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import BaseFeatureInterface
import UIKit


public final class WebViewComponent: Component<EmptyDependency>, WebViewFactory {
    public func makeView(title: String, url: String) -> UIViewController {
        WebViewController(naviTitle: title, url: url)
    }
}
