//
//  Font+PrintingAlley.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/04.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public extension UIFont {
    enum AlleyFontSystem: PrintingAlleyFontable {
        case h1
        case h2
        case subtitle1
        case subtitle2
        case subtitle3
        case body1
        case body2
        case caption1
        case caption2
    }
    
    static func setFont(_ style: AlleyFontSystem) -> UIFont {
        return style.font
    }
}

public extension UIFont.AlleyFontSystem {
    var font: UIFont {
        switch self {
        case .h1:
            return UIFont(font: DesignSystemFontFamily.Pretendard.semiBold, size: 28) ?? .init()
        case .h2:
            return UIFont(font: DesignSystemFontFamily.Pretendard.semiBold, size: 24) ?? .init()
        case .subtitle1:
            return UIFont(font: DesignSystemFontFamily.Pretendard.semiBold, size: 18) ?? .init()
        case .subtitle2:
            return UIFont(font: DesignSystemFontFamily.Pretendard.semiBold, size: 16) ?? .init()
        case .subtitle3:
            return UIFont(font: DesignSystemFontFamily.Pretendard.semiBold, size: 14) ?? .init()
        case .body1:
            return UIFont(font: DesignSystemFontFamily.Pretendard.regular, size: 16) ?? .init()
        case .body2:
            return UIFont(font: DesignSystemFontFamily.Pretendard.regular, size: 14) ?? .init()
        case .caption1:
            return UIFont(font: DesignSystemFontFamily.Pretendard.regular, size: 12) ?? .init()
        case .caption2:
            return UIFont(font: DesignSystemFontFamily.Pretendard.regular, size: 10) ?? .init()
        }
    }
}
