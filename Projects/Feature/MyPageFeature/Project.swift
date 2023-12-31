import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.MyPageFeature.rawValue,
    targets: [
        .interface(module: .feature(.MyPageFeature),dependencies: [
            .feature(target: .BaseFeature, type: .interface),
            .feature(target: .BookMarkFeature, type: .interface)
            
        ]),
        .implements(module: .feature(.MyPageFeature), dependencies: [
            .feature(target: .MyPageFeature, type: .interface),
            .feature(target: .SignInFeature,type: .interface),
            .feature(target: .BaseFeature),
            .domain(target: .AuthDomain, type: .interface)
        ])
    ]
)
