//
//  JwtStore.swift
//  JwtStoreInterface
//
//  Created by yongbeomkwak on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public enum JwtStoreProperties: String {
    case accessToken = "Authorization"
    

}

public protocol JwtStore {
    func save(property: JwtStoreProperties, value: String)
    func load(property: JwtStoreProperties) -> String
    func delete(property: JwtStoreProperties)
}

public protocol JwtAuthorizable {
    var jwtStore: JwtStoreProperties { get }
}


