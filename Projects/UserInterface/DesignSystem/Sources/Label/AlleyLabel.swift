//
//  AlleyLabel.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/04.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public final class AlleyLabel: UILabel {
    public var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
    
    public init(
        _ title: String = "",
        textColor: UIColor.AlleyColorSystem = .mainBlue(.blue500),
        font: UIFont.AlleyFontSystem = .subtitle2,
        alignment: NSTextAlignment = .left
    ) {
        super.init(frame: .zero)
        self.text = title
        self.font = .setFont(font)
        self.textColor = .setColor(textColor)
        self.setLineSpacing(lineHeight: font.alleyLineHeight)
        self.textAlignment = alignment
        self.numberOfLines = 0
    }
    
    public func setTitle(title: String, textColor: UIColor.AlleyColorSystem, font: UIFont.AlleyFontSystem, alignment: NSTextAlignment = .left) {
        self.text = title
        self.font = .setFont(font)
        self.textColor = .setColor(textColor)
        self.setLineSpacing(lineHeight: font.alleyLineHeight)
        self.textAlignment = alignment
    }
    
    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
