import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.RooFuture.rawValue,
    targets: [
        .implements(module: .feature(.RooFuture),dependencies: [
            .feature(target: .BaseFeature)
        ])
    ]
)
