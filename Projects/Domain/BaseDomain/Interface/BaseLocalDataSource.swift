//
//  BaseLocalDataSource.swift
//  BaseDomain
//
//  Created by yongbeomkwak on 10/13/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import Network

public protocol BaseLocalDataSource {
    func loadJwtToken() -> String
    
}
