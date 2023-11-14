//
//  PrintShopInfoViewModel.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/14.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseDomainInterface

final class PrintShopInfoViewModel {
    var printShop: PrintShopEntity!
    
    init(printShop: PrintShopEntity) {
        self.printShop = printShop
    }
}
