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

public protocol SignInDependency: Dependency {

}

public final class SignInComponent: Component<SignInDependency>, SigninFactory {
    public func makeView() -> UIViewController {
        SignInViewController(viewModel: SignInViewModel())
    }
}
