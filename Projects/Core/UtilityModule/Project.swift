import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.UtilityModule.rawValue,
    targets: [
        .implements(module: .core(.UtilityModule))
    ]
)
