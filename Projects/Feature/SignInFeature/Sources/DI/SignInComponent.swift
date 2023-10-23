//
//  SignInComponent.swift
//  SignInFeature
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import NeedleFoundation
import SignInFeatureInterface
import UIKit
import AuthDomainInterface
import UserDomainInterface

public protocol SignInDependency: Dependency {
 
    var authDomainFactory: any AuthDomainFactory { get }
    var userDomainFactory: any UserDomainFactory { get }
}

public final class SignInComponent: Component<SignInDependency>, SigninFactory {
    public func makeView() -> UIViewController {
        SignInViewController(viewModel: SignInViewModel(fetchLoginUseCase: dependency.authDomainFactory.fetchLoginUseCase, fetchTokenTestUseCase: dependency.authDomainFactory.fetchTokenTestUseCase, fetchUserInfoUseCase: dependency.userDomainFactory.fetchUserInfoUseCase))
    }
}
