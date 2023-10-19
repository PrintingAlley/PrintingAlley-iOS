//
//  BookMarkComponent.swift
//  BookMarkModule
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import BookMarkDomainInterface
import BookMarkFeatureInterface
import UIKit
import BaseFeatureInterface

public protocol BookMarkDependency: Dependency {
    
    var bookMarkDomainFactory: any BookMarkDomainFactory { get }
    var baseFactory: any BaseFactory { get }
}

public final class BookMarkComponent: Component<BookMarkDependency>, BookMarkFactory {
    public func makeView() -> UIViewController {
        BookMarkViewController(baseFactory: dependency.baseFactory,viewModel: BookMarkViewModel(fetchMyBookMarksUseCase: dependency.bookMarkDomainFactory.fetchMyBookMarksUseCase))
    }
}

