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
        public var id: Int
        public var name: String
        public var platform: LoginType
        public var profileImage: String?
        public var email: String?
    

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    
    init(id: Int, name: String, platform: LoginType, profileImage: String? = nil, email: String? = nil) {
        self.id = id
        self.name = name
        self.platform = platform
        self.profileImage = profileImage
        self.email = email
    }
                
    }
    
    public func setUserInfo(id: Int, name: String, profileImage: String, email: String, platform: LoginType) {
        PreferenceManager.user = UserInfo(id: id, name: name, platform: platform, profileImage: profileImage, email: email)
    }
}
