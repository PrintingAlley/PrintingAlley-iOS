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
    var editModalFactory: any EditModalFactory { get }
    var productDetailFactory: any ProductDetailFactory { get }
}

public final class BookMarkDetailComponent: Component<BookMarkDetailDependency>, BookMarkDetailFactory {

    
    public func makeView(id: Int) -> UIViewController {
        BookMarkDetailViewController(editModalFactory:dependency.editModalFactory,productDetailFactory: dependency.productDetailFactory,
                                     viewModel: BookMarkDetailViewModel(id: id,fetchBookMarkDetailUseCase: dependency.bookMarkDomainFactory.fetchBookMarkDetailUseCase, removeBookMarkUseCase: dependency.bookMarkDomainFactory.removeBookMarkUseCase))
    }
}
