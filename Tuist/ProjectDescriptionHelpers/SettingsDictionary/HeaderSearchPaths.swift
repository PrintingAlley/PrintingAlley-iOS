//
//  HeaderSearchPaths.swift
//  ProjectDescriptionHelpers
//
//  Created by yongbeomkwak on 2023/09/25.
//

import ProjectDescription

// Header 유실을 방지하기위한 셋팅

public extension SettingsDictionary {
    static let headerSearchPaths: SettingsDictionary = [
        "HEADER_SEARCH_PATHS": [
            "$(inherited)",
            "$(SRCROOT)/../../Tuist/Dependencies/SwiftPackageManager/.build/checkouts/GTMAppAuth/GTMAppAuth/Sources/Public/GTMAppAuth",
            "$(SRCROOT)/../../Tuist/Dependencies/SwiftPackageManager/.build/checkouts/gtm-session-fetcher/Sources/Core/Public"
        ],
        "OTHER_LDFLAGS" : "-ObjC"
    ]


}
