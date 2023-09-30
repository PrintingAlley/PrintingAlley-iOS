

import Foundation
import MyPageModule
import MyPageModuleInterface
import NeedleFoundation
import RooFuture
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
private class MyPageDependency48d84b530313b3ee40feProvider: MyPageDependency {


    init() {

    }
}
/// ^->AppComponent->MyPageComponent
private func factory0f6f456ebf157d02dfb3e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyPageDependency48d84b530313b3ee40feProvider()
}
private class MyPageContentDependencyc8db405cbc62d6eda9bfProvider: MyPageContentDependency {


    init() {

    }
}
/// ^->AppComponent->MyPageContentComponent
private func factory0dbf0a2ebe9a0bf09f32e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyPageContentDependencyc8db405cbc62d6eda9bfProvider()
}

#else
extension AppComponent: Registration {
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
extension MyPageComponent: Registration {
    public func registerItems() {

    }
}
extension MyPageContentComponent: Registration {
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
    registerProviderFactory("^->AppComponent->RootComponent", factory264bfc4d4cb6b0629b40e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->SignInComponent", factoryda2925fd76da866a652ae3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->MyPageComponent", factory0f6f456ebf157d02dfb3e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->MyPageContentComponent", factory0dbf0a2ebe9a0bf09f32e3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
