import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.NearByMe.rawValue,
    targets: [
        .interface(module: .feature(.NearByMe),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.NearByMe), dependencies: [
            .feature(target: .NearByMe, type: .interface),
            .feature(target: .BaseFeature)
        ]),
        .testing(module: .feature(.NearByMe), dependencies: [
            .feature(target: .NearByMe, type: .interface)
        ]),
        .tests(module: .feature(.NearByMe), dependencies: [
            .feature(target: .NearByMe)
        ]),
        .demo(module: .feature(.NearByMe), dependencies: [
            .feature(target: .NearByMe)
        ])
    ]
)
