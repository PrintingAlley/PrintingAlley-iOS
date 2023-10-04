import ConfigurationPlugin
import DependencyPlugin
import EnvironmentPlugin
import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let configurations: [Configuration] = .default

let settings: Settings = .settings(
    base: env.baseSetting.merging(.headerSearchPaths),
    configurations: configurations,
    defaultSettings: .recommended
)

let scripts: [TargetScript] = generateEnvironment.scripts

let projectDevScripts: [TargetScript] = [.needleScript,.swiftLint,.firebaseCrashlytics]
let targets: [Target] = [
    .init(
        name: env.name,
        platform: env.platform,
        product: .app,
        bundleId: "\(env.organizationName).\(env.name)",
        deploymentTarget: env.deploymentTarget,
        infoPlist: .file(path: "Support/Info.plist"),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        entitlements: "Support/\(env.name).entitlements",
        scripts:  generateEnvironment == .dev ? projectDevScripts : scripts, // 니들로 인하여 기본 스크립트와 분리 
        dependencies: [
            
            .feature(target: .RootFeature)
        ],
        settings: .settings(base: env.baseSetting)
    )
]

let schemes: [Scheme] = [
    .init(
        name: "\(env.name)-DEV",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .dev),
        archiveAction: .archiveAction(configuration: .dev),
        profileAction: .profileAction(configuration: .dev),
        analyzeAction: .analyzeAction(configuration: .dev)
    ),
    .init(
        name: "\(env.name)-STAGE",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .stage),
        archiveAction: .archiveAction(configuration: .stage),
        profileAction: .profileAction(configuration: .stage),
        analyzeAction: .analyzeAction(configuration: .stage)
    ),
    .init(
        name: "\(env.name)-PROD",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.name)"]),
        runAction: .runAction(configuration: .prod),
        archiveAction: .archiveAction(configuration: .prod),
        profileAction: .profileAction(configuration: .prod),
        analyzeAction: .analyzeAction(configuration: .prod)
    )
]

let project = Project(
    name: env.name,
    organizationName: env.organizationName,
    settings: settings,
    targets: targets,
    schemes: schemes
)
