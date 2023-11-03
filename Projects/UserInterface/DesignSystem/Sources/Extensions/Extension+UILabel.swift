//
//  Extension+UILabel.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/04.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public extension UILabel {

    /// UILabel의 행간과 자간을 조절하는 함수
    /// - Parameters:
    ///   - kernValue: 자간
    ///   - lineSpacing: 행간
    ///   - lineHeight: 줄높이
    ///   - lineHeightMultiple: 현재 행간에 multiple value 를 줄 수 있는 값
    func setLineSpacing(kernValue: Double = 0.0, lineSpacing: CGFloat = 0.0, lineHeight: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
    
    
    /// 2문자열을 다른 색, 다른 폰트롤 적용해 하나의 문자열로 만들어 Label에 넣어준다
    /// - Parameters:
    ///   - text1: 프론트 텍스트
    ///   - text2: 백 텍스트
    ///   - color1: 프론트 텍스트 색
    ///   - color2: 백 텍스트 색
    ///   - font1: 프론트 텍스트 폰트
    ///   - font2: 백 텍스트 폰트
    func setMultipleAttributeText(text1: String, text2: String, color1: UIColor, color2: UIColor, font1: UIFont.AlleyFontSystem, font2: UIFont.AlleyFontSystem) {
    
        let attrText1 = NSMutableAttributedString(string: text1)
        let range1 = (text1 as NSString).range(of: text1)
        
        let attrText2 = NSMutableAttributedString(string: text2)
        let range2 = (text2 as NSString).range(of: text2)
        
        attrText1.addAttribute(.foregroundColor, value: color1, range:  range1)
        attrText1.addAttribute(.font, value: font1.font, range: range1)
    
        
        
        attrText2.addAttribute(.foregroundColor, value: color2, range:  range2)
        attrText2.addAttribute(.font, value: font2.font, range: range2)
        
        attrText1.append(attrText2)
        self.attributedText = attrText1
        
    }
}
