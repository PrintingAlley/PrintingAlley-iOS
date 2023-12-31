//
//  Config.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/26.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

// use: colorFromRGB(0xffffff)
public func colorFromRGB(_ rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
    UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0xFF) / 255.0, alpha: alpha)
}

// use: colorFromRGB("ffffff")
public func colorFromRGB(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
    let hexToInt = UInt32(Float64("0x" + hexString) ?? 0)
    
    return UIColor(red: CGFloat((hexToInt & 0xFF0000) >> 16) / 255.0,
                   green: CGFloat((hexToInt & 0xFF00) >> 8) / 255.0,
                   blue: CGFloat(hexToInt & 0xFF) / 255.0, alpha: alpha)
}

public func DEBUG_LOG(_ msg: Any, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEV
        let fileName = file.split(separator: "/").last ?? ""
        let funcName = function.split(separator: "(").first ?? ""
        print("[\(fileName)] \(funcName)(\(line)): \(msg)")
    #endif
    
}
public func CONFIG() -> [String: Any] {

    #if DEV
    guard let config = Bundle.main.object(forInfoDictionaryKey: "Dev") as? [String: Any] else {
        
        return [:]
    }
    return config
    
    #else
    guard let config = Bundle.main.object(forInfoDictionaryKey: "Prod") as? [String: Any] else {
        return [:]
    }
    return config
    
    #endif
}

public func GOOGLE_CLIENT_ID() -> String {
    
    CONFIG()["GOOGLE_CLIENT_ID"] as? String ?? ""
    
}

public func KAKAO_APP_KEY() -> String {
    
    CONFIG()["KAKAO_APP_KEY"] as? String ?? ""
    
}
  
public func NAVER_CLIENT_ID() -> String {
    
    CONFIG()["NAVER_CLIENT_ID"] as? String ?? ""
    
}

public func NAVER_SECRET() -> String {
    
    CONFIG()["NAVER_SECRET"] as? String ?? ""
    
}

public func NAVER_MAP_CLIENT_ID() -> String {
    
    CONFIG()["NAVER_MAP_CLIENT_ID"] as? String ?? ""
    
}

public func APP_ID() -> String {
    CONFIG()["APP_ID"] as? String ?? ""
}

public func WEB_URL() -> String {
    CONFIG()["WEB_URL"] as? String ?? ""
}
