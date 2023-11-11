//
//  RootComponent.swift
//  RootFeature
//
//  Created by yongbeomkwak on 2023/09/24.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import MainTabFeatureInterface
import UserDomainInterface
import AuthDomainInterface

public protocol RootDependency: Dependency {
    var mainTabFactory: any MainTabFactory { get }
    var userDomainFactory: any UserDomainFactory { get }
    var authDomainFactory: any AuthDomainFactory { get }
}

public final class RootComponent: Component<RootDependency> {
    public func makeView() -> RootViewController {
        return RootViewController(mainTabFactory:dependency.mainTabFactory,viewModel: RootViewModel(logOutUseCase: dependency.authDomainFactory.logOutUseCase, verifyUserUseCase:  dependency.authDomainFactory.verifyUserUseCase, versionCheckUseCase: dependency.authDomainFactory.versionCheckUseCase))
    }
}
