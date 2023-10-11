import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.NearByMeFeature.rawValue,
    targets: [
        .interface(module: .feature(.NearByMeFeature),dependencies: [
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .implements(module: .feature(.NearByMeFeature) , dependencies: [
            .feature(target: .NearByMeFeature, type: .interface),
            .feature(target: .BaseFeature)
        ]),
        .testing(module: .feature(.NearByMeFeature), dependencies: [
            .feature(target: .NearByMeFeature, type: .interface)
        ]),
        .tests(module: .feature(.NearByMeFeature), dependencies: [
            .feature(target: .NearByMeFeature)
        ]),
        .demo(module: .feature(.NearByMeFeature), dependencies: [
            .feature(target: .NearByMeFeature)
        ])
    ]
)
