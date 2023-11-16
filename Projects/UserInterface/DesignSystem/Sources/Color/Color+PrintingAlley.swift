//
//  Color+PrintingAlley.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/04.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public extension UIColor {
    enum AlleyColorSystem {
        case mainBlue(Mainblue)
        case grey(Grey)
        case sub(Sub)
        case yellow(Yellow)
    }
    
    static func setColor(_ style: AlleyColorSystem) -> UIColor {
        switch style {
        case let .mainBlue(colorable as PrintingAlleyColorable):
            return colorable.color

        case let .grey(colorable as PrintingAlleyColorable):
            return colorable.color
            
        case let .sub(colorable as PrintingAlleyColorable):
            return colorable.color
            
        case let .yellow(colorable as PrintingAlleyColorable):
            return colorable.color
        }
    }
}
