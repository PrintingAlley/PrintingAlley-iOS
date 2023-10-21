//
//  MyPageComponent.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import MyPageFeatureInterface
import UIKit
import BookMarkFeatureInterface
import UserDomainInterface

public protocol MyPageContentDependency: Dependency {
    var bookMarkFactory: any BookMarkFactory { get }
    var userDomainFactory: any UserDomainFactory { get }
}

public final class MyPageContentComponent: Component<MyPageContentDependency>, MyPageContentFactory {
    public func makeView() -> UIViewController {
        MyPageContentViewController(bookMarkFactory: dependency.bookMarkFactory,viewModel: MyPageContentViewModel(fetchUserInfoUseCase: dependency.userDomainFactory.fetchUserInfoUseCase, renameUserUseCase: dependency.userDomainFactory.renameUserUseCase))
    }
}
