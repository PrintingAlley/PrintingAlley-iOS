import ProjectDescription
import ConfigurationPlugin

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/uber/needle.git", requirement: .upToNextMajor(from: "0.24.0")),
            .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "10.15.0")),
            .remote(url: "https://github.com/kyungkoo/naveridlogin-ios-sp",requirement:.upToNextMajor(from: "4.1.5")),
            .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .upToNextMajor(from: "7.0.0")),
            .remote(url: "https://github.com/kakao/kakao-ios-sdk.git", requirement: .upToNextMajor(from: "2.17.0")),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.6.0")),
            .remote(url: "https://github.com/devxoul/Then.git", requirement: .upToNextMajor(from: "3.0.0")),
            .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.3")),
            .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.9.1")),
            .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.6.0")),
            .remote(url: "https://github.com/jaemyeong/NMapsMap.git", requirement: .upToNextMajor(from: "3.16.2")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMajor(from: "5.0.2")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxKeyboard.git", requirement: .upToNextMajor(from: "2.0.1")),
            .remote(url: "https://github.com/scenee/FloatingPanel.git", requirement: .upToNextMajor(from: "2.8.0"))
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: .dev),
                .debug(name: .stage),
                .release(name: .prod)
            ]
        )
        
    ),
    platforms: [.iOS]
)
