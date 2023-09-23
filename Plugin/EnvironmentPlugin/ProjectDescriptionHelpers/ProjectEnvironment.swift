import Foundation
import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let targetName:String
    public let organizationName: String
    public let deploymentTarget: DeploymentTarget
    public let platform: Platform
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    name: "인쇄골목",
    targetName: "PrintingAlley",
    organizationName: "com",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    platform: .iOS,
    baseSetting: [:]
)
