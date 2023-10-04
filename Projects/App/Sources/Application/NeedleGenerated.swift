

import Foundation
import MyPageFeature
import MyPageFeatureInterface
import NeedleFoundation
import RootFeature
import SignInFeature
import SignInFeatureInterface
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class MyPageDependency48d84b530313b3ee40feProvider: MyPageDependency {
    var signInFactory: any SigninFactory {
        return appComponent.signInFactory
    }
    var myPageContentFactory: any MyPageContentFactory {
        return appComponent.myPageContentFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->MyPageComponent
private func factory0f6f456ebf157d02dfb3f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyPageDependency48d84b530313b3ee40feProvider(appComponent: parent1(component) as! AppComponent)
}
private class MyPageContentDependencyc8db405cbc62d6eda9bfProvider: MyPageContentDependency {


    init() {

    }
}
/// ^->AppComponent->MyPageContentComponent
private func factory0dbf0a2ebe9a0bf09f32e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyPageContentDependencyc8db405cbc62d6eda9bfProvider()
}
private class RootDependency3944cc797a4a88956fb5Provider: RootDependency {


    init() {

    }
}
/// ^->AppComponent->RootComponent
private func factory264bfc4d4cb6b0629b40e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RootDependency3944cc797a4a88956fb5Provider()
}
private class SignInDependency5dda0dd015447272446cProvider: SignInDependency {


    init() {

    }
}
/// ^->AppComponent->SignInComponent
private func factoryda2925fd76da866a652ae3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SignInDependency5dda0dd015447272446cProvider()
}

#else
extension AppComponent: Registration {
    public func registerItems() {


    }
}
extension MyPageComponent: Registration {
    public func registerItems() {
        keyPathToName[\MyPageDependency.signInFactory] = "signInFactory-any SigninFactory"
        keyPathToName[\MyPageDependency.myPageContentFactory] = "myPageContentFactory-any MyPageContentFactory"
    }
}
extension MyPageContentComponent: Registration {
    public func registerItems() {

    }
}
extension RootComponent: Registration {
    public func registerItems() {

    }
}
extension SignInComponent: Registration {
    public func registerItems() {

    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->MyPageComponent", factory0f6f456ebf157d02dfb3f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->MyPageContentComponent", factory0dbf0a2ebe9a0bf09f32e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->RootComponent", factory264bfc4d4cb6b0629b40e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->SignInComponent", factoryda2925fd76da866a652ae3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
