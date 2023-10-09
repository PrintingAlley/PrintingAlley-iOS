

import AuthDomain
import AuthDomainInterface
import Foundation
import JwtStore
import JwtStoreInterface
import KeychainModule
import KeychainModuleInterface
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

private class JwtStoreDependency5613ee3d4fea5093f6faProvider: JwtStoreDependency {
    var keychainFactory: any KeychainFactory {
        return appComponent.keychainFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->JwtStoreComponent
private func factoryb27d5aae1eb7e73575a6f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return JwtStoreDependency5613ee3d4fea5093f6faProvider(appComponent: parent1(component) as! AppComponent)
}
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
private class AuthDomainDependency4518b8977185a5c9ff71Provider: AuthDomainDependency {
    var jwtStoreFactory: any JwtStoreFactory {
        return appComponent.jwtStoreFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->AuthDomainComponent
private func factoryc9b20c320bb79402d4c1f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthDomainDependency4518b8977185a5c9ff71Provider(appComponent: parent1(component) as! AppComponent)
}

#else
extension JwtStoreComponent: Registration {
    public func registerItems() {
        keyPathToName[\JwtStoreDependency.keychainFactory] = "keychainFactory-any KeychainFactory"
    }
}
extension AppComponent: Registration {
    public func registerItems() {


    }
}
extension KeychainComponent: Registration {
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
extension AuthDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
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
    registerProviderFactory("^->AppComponent->JwtStoreComponent", factoryb27d5aae1eb7e73575a6f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->KeychainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->MyPageComponent", factory0f6f456ebf157d02dfb3f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->MyPageContentComponent", factory0dbf0a2ebe9a0bf09f32e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->RootComponent", factory264bfc4d4cb6b0629b40e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->SignInComponent", factoryda2925fd76da866a652ae3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->AuthDomainComponent", factoryc9b20c320bb79402d4c1f47b58f8f304c97af4d5)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
