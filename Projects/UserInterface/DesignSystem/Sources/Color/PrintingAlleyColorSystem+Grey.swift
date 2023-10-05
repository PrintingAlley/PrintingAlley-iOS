//
//  PrintingAlleyColorSystem+Grey.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public extension UIColor.AlleyColorSystem {
    enum Grey: PrintingAlleyColorable {
        case grey50
        case grey100
        case grey200
        case grey300
        case grey400
        case grey500
        case grey600
        case grey700
        case grey800
        case grey900
        case grey1000
    }
}

public extension UIColor.AlleyColorSystem.Grey {
    var color: UIColor {
        switch self {
        case .grey50: return DesignSystemAsset.Grey.grey50.color
        case .grey100: return DesignSystemAsset.Grey.grey100.color
        case .grey200: return DesignSystemAsset.Grey.grey200.color
        case .grey300: return DesignSystemAsset.Grey.grey300.color
        case .grey400: return DesignSystemAsset.Grey.grey400.color
        case .grey500: return DesignSystemAsset.Grey.grey500.color
        case .grey600: return DesignSystemAsset.Grey.grey600.color
        case .grey700: return DesignSystemAsset.Grey.grey700.color
        case .grey800: return DesignSystemAsset.Grey.grey800.color
        case .grey900: return DesignSystemAsset.Grey.grey900.color
        case .grey1000: return DesignSystemAsset.Grey.grey1000.color
        }
    }
}
