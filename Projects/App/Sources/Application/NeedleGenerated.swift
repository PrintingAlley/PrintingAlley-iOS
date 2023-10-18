

import AuthDomain
import AuthDomainInterface
import BookMarkDomain
import BookMarkDomainInterface
import BookMarkFeature
import BookMarkFeatureInterface
import Foundation
import HomeFeature
import HomeFeatureInterface
import JwtStore
import JwtStoreInterface
import KeychainModule
import KeychainModuleInterface
import MainTabFeature
import MainTabFeatureInterface
import MyPageFeature
import MyPageFeatureInterface
import NearByMeFeature
import NearByMeFeatureInterface
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
private class MainTabDependency2826cdb310ed0b17a725Provider: MainTabDependency {
    var mypageFactory: any MyPageFactory {
        return appComponent.mypageFactory
    }
    var homeFactory: any HomeFactory {
        return appComponent.homeFactory
    }
    var nearByMeFactory: any NearByMeFactory {
        return appComponent.nearByMeFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->MainTabComponent
private func factory1ab5a747ddf21e1393f9f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MainTabDependency2826cdb310ed0b17a725Provider(appComponent: parent1(component) as! AppComponent)
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
    var bookMarkFactory: any BookMarkFactory {
        return appComponent.bookMarkFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->MyPageContentComponent
private func factory0dbf0a2ebe9a0bf09f32f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyPageContentDependencyc8db405cbc62d6eda9bfProvider(appComponent: parent1(component) as! AppComponent)
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
    var authDomainFactory: any AuthDomainFactory {
        return appComponent.authDomainFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->SignInComponent
private func factoryda2925fd76da866a652af47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SignInDependency5dda0dd015447272446cProvider(appComponent: parent1(component) as! AppComponent)
}
private class HomeDependency443c4e1871277bd8432aProvider: HomeDependency {
    var homeFactory: any HomeFactory {
        return appComponent.homeFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->HomeComponent
private func factory67229cdf0f755562b2b1f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeDependency443c4e1871277bd8432aProvider(appComponent: parent1(component) as! AppComponent)
}
private class NearByMeDependencyfb289c9eb0cc94c83621Provider: NearByMeDependency {


    init() {

    }
}
/// ^->AppComponent->NearByMeComponent
private func factory53f303ca6b0d301565d8e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return NearByMeDependencyfb289c9eb0cc94c83621Provider()
}
private class BookMarkDependency8b686eab048ca50fc073Provider: BookMarkDependency {
    var bookMarkDomainFactory: any BookMarkDomainFactory {
        return appComponent.bookMarkDomainFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->BookMarkComponent
private func factory28d0c1b9536190951087f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return BookMarkDependency8b686eab048ca50fc073Provider(appComponent: parent1(component) as! AppComponent)
}
private class BookMarkDomainDependency2ef018453822a996a9abProvider: BookMarkDomainDependency {
    var jwtStoreFactory: any JwtStoreFactory {
        return appComponent.jwtStoreFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->BookMarkDomainComponent
private func factory9b3fac1bd377f0830537f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return BookMarkDomainDependency2ef018453822a996a9abProvider(appComponent: parent1(component) as! AppComponent)
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
extension MainTabComponent: Registration {
    public func registerItems() {
        keyPathToName[\MainTabDependency.mypageFactory] = "mypageFactory-any MyPageFactory"
        keyPathToName[\MainTabDependency.homeFactory] = "homeFactory-any HomeFactory"
        keyPathToName[\MainTabDependency.nearByMeFactory] = "nearByMeFactory-any NearByMeFactory"
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
        keyPathToName[\MyPageContentDependency.bookMarkFactory] = "bookMarkFactory-any BookMarkFactory"
    }
}
extension RootComponent: Registration {
    public func registerItems() {

    }
}
extension SignInComponent: Registration {
    public func registerItems() {
        keyPathToName[\SignInDependency.authDomainFactory] = "authDomainFactory-any AuthDomainFactory"
    }
}
extension HomeComponent: Registration {
    public func registerItems() {
        keyPathToName[\HomeDependency.homeFactory] = "homeFactory-any HomeFactory"
    }
}
extension NearByMeComponent: Registration {
    public func registerItems() {

    }
}
extension BookMarkComponent: Registration {
    public func registerItems() {
        keyPathToName[\BookMarkDependency.bookMarkDomainFactory] = "bookMarkDomainFactory-any BookMarkDomainFactory"
    }
}
extension BookMarkDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\BookMarkDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
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
    registerProviderFactory("^->AppComponent->MainTabComponent", factory1ab5a747ddf21e1393f9f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->MyPageComponent", factory0f6f456ebf157d02dfb3f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->MyPageContentComponent", factory0dbf0a2ebe9a0bf09f32f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->RootComponent", factory264bfc4d4cb6b0629b40e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->SignInComponent", factoryda2925fd76da866a652af47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->HomeComponent", factory67229cdf0f755562b2b1f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->NearByMeComponent", factory53f303ca6b0d301565d8e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->BookMarkComponent", factory28d0c1b9536190951087f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->BookMarkDomainComponent", factory9b3fac1bd377f0830537f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->AuthDomainComponent", factoryc9b20c320bb79402d4c1f47b58f8f304c97af4d5)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
