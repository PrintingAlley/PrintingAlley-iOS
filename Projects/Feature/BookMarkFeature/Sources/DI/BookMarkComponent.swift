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

public protocol BookMarkDependency: Dependency {
    
    var bookMarkDomainFactory: BookMarkDomainFactory { get }

}

public final class BookMarkComponent: Component<BookMarkDependency>, BookMarkFactory {
    public func makeView() -> UIViewController {
        BookMarkViewController(viewModel: BookMarkViewModel(fetchMyBookMarksUseCase: dependency.bookMarkDomainFactory.fetchMyBookMarksUseCase))
    }
}

