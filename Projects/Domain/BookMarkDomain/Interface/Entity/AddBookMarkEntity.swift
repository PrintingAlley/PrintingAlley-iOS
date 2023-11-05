//
//  AddBookMarkEntity.swift
//  BaseDomainInterface
//
//  Created by yongbeomkwak on 11/5/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct AddBookMarkEntity {
    
    public let statusCode: Int
    public let message: String
    public let dataId:Int
    
    public init(statusCode: Int, message: String, dataId: Int) {
        self.statusCode = statusCode
        self.message = message
        self.dataId = dataId
    }
    
    

}
