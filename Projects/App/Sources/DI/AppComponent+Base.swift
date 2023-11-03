//
//  AppComponent+Base.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import BaseFeature

extension AppComponent {
    var editModalFactory: any EditModalFactory {
        EditModalComponent(parent: self)
    }
    
    var bookMarkBottomSheetFactory: any BookMarkBottomSheetFactory {
        BookMarkBottomSheetComponent(parent: self)
    }
    
    var productDetailComponent: any ProductDetailFactory {
        ProductDetailComponent(parent: self)
    }
}
