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
            .remote(url: "https://github.com/kakao/kakao-ios-sdk-rx.git", requirement: .upToNextMajor(from: "2.17.0"))
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
