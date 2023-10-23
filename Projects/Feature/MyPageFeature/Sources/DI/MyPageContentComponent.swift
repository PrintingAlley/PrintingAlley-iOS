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
import BaseFeatureInterface
import AuthDomainInterface

public protocol MyPageContentDependency: Dependency {
    var bookMarkFactory: any BookMarkFactory { get }
    var userDomainFactory: any UserDomainFactory { get }
    var editModalFactory: any EditModalFactory { get }
    var authDomainFactory: any AuthDomainFactory { get }
}

public final class MyPageContentComponent: Component<MyPageContentDependency>, MyPageContentFactory {
    public func makeView() -> UIViewController {
        MyPageContentViewController(bookMarkFactory: dependency.bookMarkFactory, editModalFactory: dependency.editModalFactory,viewModel: MyPageContentViewModel(fetchUserInfoUseCase: dependency.userDomainFactory.fetchUserInfoUseCase, logOutUseCase: dependency.authDomainFactory.logOutUseCase, withDrawUseCase: dependency.authDomainFactory.withDrawUseCase))
    }
}
