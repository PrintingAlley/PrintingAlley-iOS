//
//  WebViewFactory.swift
//  BaseFeatureInterface
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit


public protocol WebViewFactory {
    func makeView(title: String, url: String) -> UIViewController
}
