//
//  AppComponent+MyPage.swift
//  PrintingAlley
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import MyPageModuleInterface
import MyPageModule

extension AppComponent {
    
    var myPageContentFactory: any MyPageContentFactory {
        MyPageContentComponent(parent: self)
    }
    
    var mypageFactory: any MyPageFactory {
        MyPageComponent(parent: self)
    }
    

}
