import ProjectDescription
import Foundation

public extension TargetScript {
    static let swiftLint = TargetScript.pre(
        path: Path.relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLint"
    )
    
    static let needleScript = TargetScript.pre(
        path: Path.relativeToRoot("Scripts/NeedleRunScript.sh"),
        name: "Needle"
    )
    
    static let firebaseCrashlytics = TargetScript.post(
            script:
                """
                ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
                "${ROOT_DIR}/Tuist/Dependencies/SwiftPackageManager/.build/checkouts/firebase-ios-sdk/Crashlytics/run"
                """
            ,
            name: "FirebaseCrashlytics",
            inputPaths: [
                "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}",
                "$(SRCROOT)/$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)"
            ]
        )
}
