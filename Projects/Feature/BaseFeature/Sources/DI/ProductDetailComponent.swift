//
//  ProductDetailComponent.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import BaseFeatureInterface
import NeedleFoundation
import ProductDomainInterface

public protocol ProductDetailDependency: Dependency {
    
    var bookMarkBottomSheetFactory: any BookMarkBottomSheetFactory { get }
    var productDomainFactory: any ProductDomainFactory { get }
}

public final class ProductDetailComponent: Component<ProductDetailDependency>, ProductDetailFactory {
    public func makeView(id: Int) -> UIViewController {
        ProductDetailViewController(bookMarkBottomSheetFactory: dependency.bookMarkBottomSheetFactory, viewModel: ProductDetailViewModel(id: id,fetchProductUseCase: dependency.productDomainFactory.fetchProductUseCase))
    }
    
}

