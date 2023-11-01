//
//  tmp.swift
//  PrintShopDomainInterface
//
//  Created by yongbeomkwak on 10/31/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

public struct PrintShopListEntity {
   public let printShops: [PrintShopEntity]
   public let statusCode: Int
   public let message: String
    
    
    
    public init(printShops: [PrintShopEntity], statusCode: Int, message: String) {
        self.printShops = printShops
        self.statusCode = statusCode
        self.message = message
    }
}
