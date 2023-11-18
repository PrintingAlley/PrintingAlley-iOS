

import AuthDomain
import AuthDomainInterface
import BaseDomainInterface
import BaseFeature
import BaseFeatureInterface
import BookMarkDomain
import BookMarkDomainInterface
import BookMarkFeature
import BookMarkFeatureInterface
import CategorySearchFeature
import CategorySearchFeatureInterface
import ContentDomain
import ContentDomainInterface
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
import PrintShopDomain
import PrintShopDomainInterface
import ProductDomain
import ProductDomainInterface
import RootFeature
import SearchFeatue
import SearchFeatueInterface
import SignInFeature
import SignInFeatureInterface
import TagDomain
import TagDomainInterface
import UIKit
import UserDomain
import UserDomainInterface

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
    var searchFactory: any SearchFactory {
        return appComponent.searchFactory
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
    var userDomainFactory: any UserDomainFactory {
        return appComponent.userDomainFactory
    }
    var editModalFactory: any EditModalFactory {
        return appComponent.editModalFactory
    }
    var authDomainFactory: any AuthDomainFactory {
        return appComponent.authDomainFactory
    }
    var webViewFactory: any WebViewFactory {
        return appComponent.webViewFactory
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
private class SearchDependencya86903a2c751a4f762e8Provider: SearchDependency {
    var printShopDomainFactory: any PrintShopDomainFactory {
        return appComponent.printShopDomainFactory
    }
    var printShopDetailFactory: any PrintShopDetailFactory {
        return appComponent.printShopDetailFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->SearchComponent
private func factorye3d049458b2ccbbcb3b6f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SearchDependencya86903a2c751a4f762e8Provider(appComponent: parent1(component) as! AppComponent)
}
private class RootDependency3944cc797a4a88956fb5Provider: RootDependency {
    var mainTabFactory: any MainTabFactory {
        return appComponent.mainTabFactory
    }
    var userDomainFactory: any UserDomainFactory {
        return appComponent.userDomainFactory
    }
    var authDomainFactory: any AuthDomainFactory {
        return appComponent.authDomainFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->RootComponent
private func factory264bfc4d4cb6b0629b40f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RootDependency3944cc797a4a88956fb5Provider(appComponent: parent1(component) as! AppComponent)
}
private class SignInDependency5dda0dd015447272446cProvider: SignInDependency {
    var authDomainFactory: any AuthDomainFactory {
        return appComponent.authDomainFactory
    }
    var userDomainFactory: any UserDomainFactory {
        return appComponent.userDomainFactory
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
    var tagDomainFactory: any TagDomainFactory {
        return appComponent.tagDomainFactory
    }
    var categorySearchFactory: any CategorySearchFactory {
        return appComponent.categorySearchFactory
    }
    var contentDomainFactory: any ContentDomainFactory {
        return appComponent.contentDomainFactory
    }
    var webViewFactory: any WebViewFactory {
        return appComponent.webViewFactory
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
private class CategorySearchDependencybc5b867b843f81f14b34Provider: CategorySearchDependency {
    var productDomainFactory: any ProductDomainFactory {
        return appComponent.productDomainFactory
    }
    var filterFactory: any FilterFactory {
        return appComponent.filterFactory
    }
    var productDetailFactory: any ProductDetailFactory {
        return appComponent.productDetailFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->CategorySearchComponent
private func factory89ce28b4b2dfd923cbdcf47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return CategorySearchDependencybc5b867b843f81f14b34Provider(appComponent: parent1(component) as! AppComponent)
}
private class FilterDependencya3adf5d0affb84ca15efProvider: FilterDependency {
    var tagDomainFactory: any TagDomainFactory {
        return appComponent.tagDomainFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->FilterComponent
private func factoryf50b858bcdf190c46b17f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return FilterDependencya3adf5d0affb84ca15efProvider(appComponent: parent1(component) as! AppComponent)
}
private class BookMarkDependency8b686eab048ca50fc073Provider: BookMarkDependency {
    var bookMarkDomainFactory: any BookMarkDomainFactory {
        return appComponent.bookMarkDomainFactory
    }
    var bookMarkDetailFactory: any BookMarkDetailFactory {
        return appComponent.bookMarkDetailFactory
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
private class BookMarkDetailDependency82d727e486e840545c2dProvider: BookMarkDetailDependency {
    var bookMarkDomainFactory: any BookMarkDomainFactory {
        return appComponent.bookMarkDomainFactory
    }
    var editModalFactory: any EditModalFactory {
        return appComponent.editModalFactory
    }
    var productDetailFactory: any ProductDetailFactory {
        return appComponent.productDetailFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->BookMarkDetailComponent
private func factoryc8e52bb402c24cd9a5e2f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return BookMarkDetailDependency82d727e486e840545c2dProvider(appComponent: parent1(component) as! AppComponent)
}
private class BookMarkBottomSheetDependency573e6d5ba0463bb7b63bProvider: BookMarkBottomSheetDependency {
    var bookMarkDomainFactory: any BookMarkDomainFactory {
        return appComponent.bookMarkDomainFactory
    }
    var editModalFactory: any EditModalFactory {
        return appComponent.editModalFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->BookMarkBottomSheetComponent
private func factory04ad8419cbe014f877eaf47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return BookMarkBottomSheetDependency573e6d5ba0463bb7b63bProvider(appComponent: parent1(component) as! AppComponent)
}
private class EditModalDependencye914ce2425a804be0d58Provider: EditModalDependency {
    var bookMarkDomainFactory: any BookMarkDomainFactory {
        return appComponent.bookMarkDomainFactory
    }
    var userDomainFactory: any UserDomainFactory {
        return appComponent.userDomainFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->EditModalComponent
private func factory05e011369db72b170e1ef47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EditModalDependencye914ce2425a804be0d58Provider(appComponent: parent1(component) as! AppComponent)
}
private class PrintShopDetailDependency796e358411338a10d23bProvider: PrintShopDetailDependency {
    var printShopDomainFactory: any PrintShopDomainFactory {
        return appComponent.printShopDomainFactory
    }
    var printShopInfoFactory: any PrintShopInfoFactory {
        return appComponent.printShopInfoFactory
    }
    var printShopProductsFactory: any PrintShopProductsFactory {
        return appComponent.printShopProductsFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->PrintShopDetailComponent
private func factory2be1884dea2b5d392babf47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return PrintShopDetailDependency796e358411338a10d23bProvider(appComponent: parent1(component) as! AppComponent)
}
private class ProductDetailDependency1e6e934c90b49cbc48b5Provider: ProductDetailDependency {
    var printShopDetailFactory: any PrintShopDetailFactory {
        return appComponent.printShopDetailFactory
    }
    var bookMarkBottomSheetFactory: any BookMarkBottomSheetFactory {
        return appComponent.bookMarkBottomSheetFactory
    }
    var productDomainFactory: any ProductDomainFactory {
        return appComponent.productDomainFactory
    }
    var bookMarkDomainFactory: any BookMarkDomainFactory {
        return appComponent.bookMarkDomainFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->ProductDetailComponent
private func factorydd8ac0cf9df6ffed7cb6f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ProductDetailDependency1e6e934c90b49cbc48b5Provider(appComponent: parent1(component) as! AppComponent)
}
private class PrintShopProductsDependencyf34e490a03abe7ccf2b8Provider: PrintShopProductsDependency {
    var productDetailFactory: any ProductDetailFactory {
        return appComponent.productDetailFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->PrintShopProductsComponent
private func factory653fb1901f08bc07d079f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return PrintShopProductsDependencyf34e490a03abe7ccf2b8Provider(appComponent: parent1(component) as! AppComponent)
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
private class ContentDomainDependencye01728553bb650fbed25Provider: ContentDomainDependency {
    var jwtStoreFactory: any JwtStoreFactory {
        return appComponent.jwtStoreFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->ContentDomainComponent
private func factory5918d17a9811afd8dadef47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ContentDomainDependencye01728553bb650fbed25Provider(appComponent: parent1(component) as! AppComponent)
}
private class ProductDomainDependency46ea2c6b79a1a6907fb1Provider: ProductDomainDependency {
    var jwtStoreFactory: any JwtStoreFactory {
        return appComponent.jwtStoreFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->ProductDomainComponent
private func factory5ac7597a79163de1a05ff47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ProductDomainDependency46ea2c6b79a1a6907fb1Provider(appComponent: parent1(component) as! AppComponent)
}
private class TagDomainDependency8436ae71fd9cf2012d70Provider: TagDomainDependency {
    var jwtStoreFactory: any JwtStoreFactory {
        return appComponent.jwtStoreFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->TagDomainComponent
private func factory6a92323f94d86d563660f47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return TagDomainDependency8436ae71fd9cf2012d70Provider(appComponent: parent1(component) as! AppComponent)
}
private class PrintShopDomainDependency7e887160334225a022d6Provider: PrintShopDomainDependency {
    var jwtStoreFactory: any JwtStoreFactory {
        return appComponent.jwtStoreFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->PrintShopDomainComponent
private func factoryc5a02ffad7cab4fbb37af47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return PrintShopDomainDependency7e887160334225a022d6Provider(appComponent: parent1(component) as! AppComponent)
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
private class UserDomainDependencyf39d2a2922733361cbe1Provider: UserDomainDependency {
    var jwtStoreFactory: any JwtStoreFactory {
        return appComponent.jwtStoreFactory
    }
    private let appComponent: AppComponent
    init(appComponent: AppComponent) {
        self.appComponent = appComponent
    }
}
/// ^->AppComponent->UserDomainComponent
private func factory46488402f315d7f9530cf47b58f8f304c97af4d5(_ component: NeedleFoundation.Scope) -> AnyObject {
    return UserDomainDependencyf39d2a2922733361cbe1Provider(appComponent: parent1(component) as! AppComponent)
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
        keyPathToName[\MainTabDependency.searchFactory] = "searchFactory-any SearchFactory"
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
        keyPathToName[\MyPageContentDependency.userDomainFactory] = "userDomainFactory-any UserDomainFactory"
        keyPathToName[\MyPageContentDependency.editModalFactory] = "editModalFactory-any EditModalFactory"
        keyPathToName[\MyPageContentDependency.authDomainFactory] = "authDomainFactory-any AuthDomainFactory"
        keyPathToName[\MyPageContentDependency.webViewFactory] = "webViewFactory-any WebViewFactory"
    }
}
extension SearchComponent: Registration {
    public func registerItems() {
        keyPathToName[\SearchDependency.printShopDomainFactory] = "printShopDomainFactory-any PrintShopDomainFactory"
        keyPathToName[\SearchDependency.printShopDetailFactory] = "printShopDetailFactory-any PrintShopDetailFactory"
    }
}
extension RootComponent: Registration {
    public func registerItems() {
        keyPathToName[\RootDependency.mainTabFactory] = "mainTabFactory-any MainTabFactory"
        keyPathToName[\RootDependency.userDomainFactory] = "userDomainFactory-any UserDomainFactory"
        keyPathToName[\RootDependency.authDomainFactory] = "authDomainFactory-any AuthDomainFactory"
    }
}
extension SignInComponent: Registration {
    public func registerItems() {
        keyPathToName[\SignInDependency.authDomainFactory] = "authDomainFactory-any AuthDomainFactory"
        keyPathToName[\SignInDependency.userDomainFactory] = "userDomainFactory-any UserDomainFactory"
    }
}
extension HomeComponent: Registration {
    public func registerItems() {
        keyPathToName[\HomeDependency.homeFactory] = "homeFactory-any HomeFactory"
        keyPathToName[\HomeDependency.tagDomainFactory] = "tagDomainFactory-any TagDomainFactory"
        keyPathToName[\HomeDependency.categorySearchFactory] = "categorySearchFactory-any CategorySearchFactory"
        keyPathToName[\HomeDependency.contentDomainFactory] = "contentDomainFactory-any ContentDomainFactory"
        keyPathToName[\HomeDependency.webViewFactory] = "webViewFactory-any WebViewFactory"
    }
}
extension NearByMeComponent: Registration {
    public func registerItems() {

    }
}
extension CategorySearchComponent: Registration {
    public func registerItems() {
        keyPathToName[\CategorySearchDependency.productDomainFactory] = "productDomainFactory-any ProductDomainFactory"
        keyPathToName[\CategorySearchDependency.filterFactory] = "filterFactory-any FilterFactory"
        keyPathToName[\CategorySearchDependency.productDetailFactory] = "productDetailFactory-any ProductDetailFactory"
    }
}
extension FilterComponent: Registration {
    public func registerItems() {
        keyPathToName[\FilterDependency.tagDomainFactory] = "tagDomainFactory-any TagDomainFactory"
    }
}
extension BookMarkComponent: Registration {
    public func registerItems() {
        keyPathToName[\BookMarkDependency.bookMarkDomainFactory] = "bookMarkDomainFactory-any BookMarkDomainFactory"
        keyPathToName[\BookMarkDependency.bookMarkDetailFactory] = "bookMarkDetailFactory-any BookMarkDetailFactory"
    }
}
extension BookMarkDetailComponent: Registration {
    public func registerItems() {
        keyPathToName[\BookMarkDetailDependency.bookMarkDomainFactory] = "bookMarkDomainFactory-any BookMarkDomainFactory"
        keyPathToName[\BookMarkDetailDependency.editModalFactory] = "editModalFactory-any EditModalFactory"
        keyPathToName[\BookMarkDetailDependency.productDetailFactory] = "productDetailFactory-any ProductDetailFactory"
    }
}
extension AlleyPageComponent: Registration {
    public func registerItems() {

    }
}
extension BookMarkBottomSheetComponent: Registration {
    public func registerItems() {
        keyPathToName[\BookMarkBottomSheetDependency.bookMarkDomainFactory] = "bookMarkDomainFactory-any BookMarkDomainFactory"
        keyPathToName[\BookMarkBottomSheetDependency.editModalFactory] = "editModalFactory-any EditModalFactory"
    }
}
extension EditModalComponent: Registration {
    public func registerItems() {
        keyPathToName[\EditModalDependency.bookMarkDomainFactory] = "bookMarkDomainFactory-any BookMarkDomainFactory"
        keyPathToName[\EditModalDependency.userDomainFactory] = "userDomainFactory-any UserDomainFactory"
    }
}
extension PrintShopInfoComponent: Registration {
    public func registerItems() {

    }
}
extension PrintShopDetailComponent: Registration {
    public func registerItems() {
        keyPathToName[\PrintShopDetailDependency.printShopDomainFactory] = "printShopDomainFactory-any PrintShopDomainFactory"
        keyPathToName[\PrintShopDetailDependency.printShopInfoFactory] = "printShopInfoFactory-any PrintShopInfoFactory"
        keyPathToName[\PrintShopDetailDependency.printShopProductsFactory] = "printShopProductsFactory-any PrintShopProductsFactory"
    }
}
extension WebViewComponent: Registration {
    public func registerItems() {

    }
}
extension ProductDetailComponent: Registration {
    public func registerItems() {
        keyPathToName[\ProductDetailDependency.printShopDetailFactory] = "printShopDetailFactory-any PrintShopDetailFactory"
        keyPathToName[\ProductDetailDependency.bookMarkBottomSheetFactory] = "bookMarkBottomSheetFactory-any BookMarkBottomSheetFactory"
        keyPathToName[\ProductDetailDependency.productDomainFactory] = "productDomainFactory-any ProductDomainFactory"
        keyPathToName[\ProductDetailDependency.bookMarkDomainFactory] = "bookMarkDomainFactory-any BookMarkDomainFactory"
    }
}
extension PrintShopProductsComponent: Registration {
    public func registerItems() {
        keyPathToName[\PrintShopProductsDependency.productDetailFactory] = "productDetailFactory-any ProductDetailFactory"
    }
}
extension BookMarkDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\BookMarkDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
    }
}
extension ContentDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\ContentDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
    }
}
extension ProductDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\ProductDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
    }
}
extension TagDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\TagDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
    }
}
extension PrintShopDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\PrintShopDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
    }
}
extension AuthDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
    }
}
extension UserDomainComponent: Registration {
    public func registerItems() {
        keyPathToName[\UserDomainDependency.jwtStoreFactory] = "jwtStoreFactory-any JwtStoreFactory"
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
    registerProviderFactory("^->AppComponent->SearchComponent", factorye3d049458b2ccbbcb3b6f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->RootComponent", factory264bfc4d4cb6b0629b40f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->SignInComponent", factoryda2925fd76da866a652af47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->HomeComponent", factory67229cdf0f755562b2b1f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->NearByMeComponent", factory53f303ca6b0d301565d8e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent->CategorySearchComponent", factory89ce28b4b2dfd923cbdcf47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->FilterComponent", factoryf50b858bcdf190c46b17f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->BookMarkComponent", factory28d0c1b9536190951087f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->BookMarkDetailComponent", factoryc8e52bb402c24cd9a5e2f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->AlleyPageComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->BookMarkBottomSheetComponent", factory04ad8419cbe014f877eaf47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->EditModalComponent", factory05e011369db72b170e1ef47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->PrintShopInfoComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->PrintShopDetailComponent", factory2be1884dea2b5d392babf47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->WebViewComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent->ProductDetailComponent", factorydd8ac0cf9df6ffed7cb6f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->PrintShopProductsComponent", factory653fb1901f08bc07d079f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->BookMarkDomainComponent", factory9b3fac1bd377f0830537f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->ContentDomainComponent", factory5918d17a9811afd8dadef47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->ProductDomainComponent", factory5ac7597a79163de1a05ff47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->TagDomainComponent", factory6a92323f94d86d563660f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->PrintShopDomainComponent", factoryc5a02ffad7cab4fbb37af47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->AuthDomainComponent", factoryc9b20c320bb79402d4c1f47b58f8f304c97af4d5)
    registerProviderFactory("^->AppComponent->UserDomainComponent", factory46488402f315d7f9530cf47b58f8f304c97af4d5)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
