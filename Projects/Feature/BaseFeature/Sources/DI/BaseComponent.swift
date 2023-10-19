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
import BookMarkDomainInterface

public protocol BaseDependency: Dependency {
    
    var bookMarkDomainFactory: any BookMarkDomainFactory { get }
}

public final class BaseComponent: Component<BaseDependency>, BaseFactory {
    public func makeBookMarkBottomSheet() -> UIViewController {
        BookMarkBottomSheetViewController(viewModel: BookMarkBottomSheetViewModel())
    }
    
    public func makeEditModal(title: String, type: EditType) -> UIViewController {
        EditModalViewController(title: title, viewModel: EditModalViewModel(type: type, generateBookMarkUseCase: dependency.bookMarkDomainFactory.generateBookMarkUseCase))
    }
    
    
 
}
