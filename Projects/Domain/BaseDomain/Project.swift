import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    targets: [
        .implements(module: .domain(.BaseDomain), dependencies: [
            .core(target: .Netwrok),
            .domain(target: .BaseDomain,type: .interface)
        ]),
        .interface(module: .domain(.BaseDomain)),
        .tests(module: .domain(.BaseDomain), dependencies: [
            .domain(target: .BaseDomain, type: .interface)
        ])
    ]
)
