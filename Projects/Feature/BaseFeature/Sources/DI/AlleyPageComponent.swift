//
//  AlleyPageComponent.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import BaseFeatureInterface
import UIKit

public final class AlleyPageComponent: Component<EmptyDependency>, AlleyPageFactory {
    public func makeView(titles: [String]) -> UIViewController {
        AlleyPageViewController(viewModel: AlleyPageViewModel(titles: titles))
    }
}
