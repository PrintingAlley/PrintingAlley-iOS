//
//  BaseComponent.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import NeedleFoundation
import UIKit

public protocol BaseDependency: Dependency {
    

}

public final class BaseComponent: Component<BaseDependency>, BaseFactory {
    public func makeBookMarkBottomSheet() -> UIViewController {
        BookMarkBottomSheetViewController(viewModel: BookMarkBottomSheetViewModel())
    }
    
    public func makeEditMoal() -> UIViewController {
        EditModalViewController()
    }
    
    
 
}
