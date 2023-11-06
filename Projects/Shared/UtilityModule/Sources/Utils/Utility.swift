//
//  Utility.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public func APP_WIDTH() -> CGFloat {
    UIScreen.main.bounds.size.width
}

public func APP_HEIGHT() -> CGFloat {
    UIScreen.main.bounds.size.height
}

public func STATUS_BAR_HEGHIT() -> CGFloat {
    
if #available(iOS 15.0, *) {
            let top = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first?.safeAreaInsets.top ?? 0

            return max(0, top)

        } else {
            let top = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
            return max(0, top)
        }
    
}

public func SAFEAREA_BOTTOM_HEIGHT() -> CGFloat {
    if #available(iOS 15.0, *) {
                let bottom = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first?.safeAreaInsets.bottom ?? 0

                return max(0, bottom)

            } else {
                let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
                return max(0, bottom)
            }
}

public func APP_VERSION() -> String {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
}

public func APP_NAME() -> String {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
}

public func OS_VERSION() -> String {
    return UIDevice.current.systemVersion
}

public func OS_NAME() -> String {
    let osName: String = {
        #if os(iOS)
        #if targetEnvironment(macCatalyst)
        return "macOS(Catalyst)"
        #else
        return "iOS"
        #endif
        #elseif os(watchOS)
        return "watchOS"
        #elseif os(tvOS)
        return "tvOS"
        #elseif os(macOS)
        return "macOS"
        #elseif os(Linux)
        return "Linux"
        #elseif os(Windows)
        return "Windows"
        #else
        return "Unknown"
        #endif
    }()
    return osName
}

public func LOGOUT() {
    PreferenceManager.user = nil 
}

public func COPY(text: String) {
    UIPasteboard.general.string = text //클립보드 복사
}


public func GRID_WIDHT() -> CGFloat {
    return (APP_WIDTH() - (16*3)) / 2
}

public func GRID_HEIGHT() -> CGFloat {
    
    return  (GRID_WIDHT() * 199.0) / 171.0
}
