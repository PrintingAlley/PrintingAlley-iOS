//
//  AlleyColorSystem+MainBlue.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/04.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public extension UIColor.AlleyColorSystem {
    enum Mainblue: PrintingAlleyColorable {
        
        case blue50
        case blue100
        case blue200
        case blue300
        case blue400
        case blue500
        case blue600
        case blue700
        case blue800
        case blue900
        case blue1000
    }
}

public extension UIColor.AlleyColorSystem.Mainblue {
    var color: UIColor {
        switch self {
        case .blue50: return DesignSystemAsset.blue50.color
        case .blue100: return DesignSystemAsset.blue100.color
        case .blue200: return DesignSystemAsset.blue200.color
        case .blue300: return DesignSystemAsset.blue300.color
        case .blue400: return DesignSystemAsset.blue400.color
        case .blue500: return DesignSystemAsset.blue500.color
        case .blue600: return DesignSystemAsset.blue600.color
        case .blue700: return DesignSystemAsset.blue700.color
        case .blue800: return DesignSystemAsset.blue800.color
        case .blue900: return DesignSystemAsset.blue900.color
        case .blue1000: return DesignSystemAsset.blue1000.color
            
        }
    }
}
