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
}
