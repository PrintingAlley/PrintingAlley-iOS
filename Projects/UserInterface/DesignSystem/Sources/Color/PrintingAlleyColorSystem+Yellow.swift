//
//  PrintingAlleyColorSystem+Yellow.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/11/16.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public extension UIColor.AlleyColorSystem {
    enum Yellow: PrintingAlleyColorable {
        case yellow50
        case yellow100
        case yellow200
        case yellow300
        case yellow400
        case yellow500
        case yellow600
        case yellow700
        case yellow800
        case yellow900
    }
}

public extension UIColor.AlleyColorSystem.Yellow {
    var color: UIColor {
        switch self {
        case .yellow50: return DesignSystemAsset.Yellow.yellow50.color
        case .yellow100: return DesignSystemAsset.Yellow.yellow100.color
        case .yellow200: return DesignSystemAsset.Yellow.yellow200.color
        case .yellow300: return DesignSystemAsset.Yellow.yellow300.color
        case .yellow400: return DesignSystemAsset.Yellow.yellow400.color
        case .yellow500: return DesignSystemAsset.Yellow.yellow500.color
        case .yellow600: return DesignSystemAsset.Yellow.yellow600.color
        case .yellow700: return DesignSystemAsset.Yellow.yellow700.color
        case .yellow800: return DesignSystemAsset.Yellow.yellow800.color
        case .yellow900: return DesignSystemAsset.Yellow.yellow900.color
        }
    }
}
