//
//  LocalAuthDataSources.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


public protocol LocalAuthDataSource {
    func loadJwtToken() -> String
    
}
