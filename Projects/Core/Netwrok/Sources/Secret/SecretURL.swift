//
//  SecretURL.swift
//  Netwrok
//
//  Created by yongbeomkwak on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


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

public func BASEURL() -> String {
    CONFIG()["BASE_URL"] as? String ?? ""
}
