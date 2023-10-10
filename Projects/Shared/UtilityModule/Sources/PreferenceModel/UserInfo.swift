//
//  UserInfo.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/10/01.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public extension PreferenceManager {
    
struct UserInfo: Codable, Equatable {
        public var id, name: String
        public var platform: LoginType

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
                
    }
    
    public func setUserInfo(id: String, name: String, platform: LoginType) {
        PreferenceManager.user = UserInfo(id: id, name: name, platform: platform)
    }
}
