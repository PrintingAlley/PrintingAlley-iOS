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
        case header1
        case header2
        case header3
        case subtitle1
        case subtitle2
        case subtitle3
        case body1
        case body2
        case body3
        case caption1
        case caption2
    }
    
    static func setFont(_ style: AlleyFontSystem) -> UIFont {
        let font = style.font
        return font
    }
    
    static func getLineHeight(_ style: AlleyFontSystem) -> CGFloat {
        let lineHeight = style.alleyLineHeight
        return lineHeight
    }
}

public extension UIFont.AlleyFontSystem {
    var font: UIFont {
        switch self {
        case .header1:
            return UIFont(font: DesignSystemFontFamily.Pretendard.semiBold, size: 28) ?? .init()

        case .header2:
            return UIFont(font: DesignSystemFontFamily.Pretendard.semiBold, size: 24) ?? .init()
            
        case .header3:
            return UIFont(font: DesignSystemFontFamily.Pretendard.medium, size: 20) ?? .init()

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
        
        case .body3:
            return UIFont(font: DesignSystemFontFamily.Pretendard.medium, size: 10) ?? .init()

        case .caption1:
            return UIFont(font: DesignSystemFontFamily.Pretendard.medium, size: 12) ?? .init()

        case .caption2:
            return UIFont(font: DesignSystemFontFamily.Pretendard.regular, size: 10) ?? .init()
        }
    }
    
    var alleyLineHeight: CGFloat {
        switch self {
        case .header1:
            return 36
            
        case .header2:
            return 32
            
        case .header3:
            return 30
            
        case .subtitle1:
            return 24
            
        case .subtitle2:
            return 24
            
        case .subtitle3:
            return 20
            
        case .body1:
            return 24
            
        case .body2:
            return 20
            
        case .body3:
            return 12
            
        case .caption1:
            return 18
            
        case .caption2:
            return 12
        }
    }
}
