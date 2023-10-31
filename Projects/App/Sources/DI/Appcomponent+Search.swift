//
//  Appcomponent+Search.swift
//  PrintingAlley
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import SearchFeatue
import SearchFeatueInterface

extension AppComponent {
    var searchFactory: any SearchFactory {
        SearchComponent(parent: self)
    }
    
    var afterSearchFactory: any AfterSearchFactory {
        AfterSearchComponent(parent: self)
    }
    
    var beforeSearchFactory: any BeforeSearchFactory {
        BeforeSearchComponent(parent: self)
    }
}
