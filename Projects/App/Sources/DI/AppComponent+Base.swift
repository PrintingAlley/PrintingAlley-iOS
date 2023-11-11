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
    
    var productDetailFactory: any ProductDetailFactory {
        ProductDetailComponent(parent: self)
    }
    
    var webViewFactory: any WebViewFactory {
        WebViewComponent(parent: self)
    }
    
    var alleyPageFactory: any AlleyPageFactory {
        AlleyPageComponent(parent: self)
    }
}
