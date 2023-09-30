//
//  ViewModelType.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/29.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
