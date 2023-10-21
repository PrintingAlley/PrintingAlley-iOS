//
//  BookMarkBottomSheetComponent.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import NeedleFoundation
import UIKit
import BookMarkDomainInterface

public protocol BookMarkBottomSheetDependency: Dependency {
    
    var bookMarkDomainFactory: any BookMarkDomainFactory { get }
    var editModalFactory: any EditModalFactory { get }
}

public final class BookMarkBottomSheetComponent: Component<BookMarkBottomSheetDependency>, BookMarkBottomSheetFactory {
    
    
    public func makeView() -> UIViewController {
        BookMarkBottomSheetViewController(editModalFactory: dependency.editModalFactory, viewModel: BookMarkBottomSheetViewModel())
    }
    
}
