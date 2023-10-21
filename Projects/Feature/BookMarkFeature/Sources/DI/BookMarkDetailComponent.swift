//
//  BookMarkDetailComponent.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import BookMarkDomainInterface
import BookMarkFeatureInterface
import UIKit
import BaseFeatureInterface

public protocol BookMarkDetailDependency: Dependency {
    
    var bookMarkDomainFactory: any BookMarkDomainFactory { get }
    var baseFactory: any BaseFactory { get }
}

public final class BookMarkDetailComponent: Component<BookMarkDetailDependency>, BookMarkDetailFactory {

    
    public func makeView(id: Int) -> UIViewController {
        BookMarkDetailViewController(baseFactory:dependency.baseFactory,
                                     viewModel: BookMarkDetailViewModel(id: id,fetchBookMarkDetailUseCase: dependency.bookMarkDomainFactory.fetchBookMarkDetailUseCase, removeBookMarkUseCase: dependency.bookMarkDomainFactory.removeBookMarkUseCase))
    }
}
