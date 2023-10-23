//
//  BookMarkEntity.swift
//  BookMarkDomainInterface
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public struct BookMarkEntity {
    public let id: Int
    public let printShop: SimplePrintShopInfoEntity
    
    public init(id: Int, printShop: SimplePrintShopInfoEntity) {
        self.id = id
        self.printShop = printShop
    }

}
