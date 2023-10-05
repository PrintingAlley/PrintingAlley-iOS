//
//  PrintingAlleyColorSystem+Sub.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem

public extension UIColor.AlleyColorSystem {
    enum Sub: PrintingAlleyColorable {
        case white
        case black
    }
}

public extension UIColor.AlleyColorSystem.Sub {
    var color: UIColor {
        switch self {
        case .white: return DesignSystemAsset.Sub.white.color
        case .black: return DesignSystemAsset.Sub.black.color
        }
    }
}
