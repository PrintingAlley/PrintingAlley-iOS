//
//  Config.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/26.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public func CONFIG() -> [String:Any] {
    
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
