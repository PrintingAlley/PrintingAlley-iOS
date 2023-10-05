//
//  AlleyLabel.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/04.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem

public final class AlleyLabel: UILabel {
    public var padding = UIEdgeInsets.zero
    
    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        print("height:\(contentSize.height)")
        print("width: \(contentSize.width)")
        
        return contentSize
    }
    
    public init(
        _ title: String = "",
        textColor: UIColor.AlleyColorSystem = .mainBlue(.blue1000),
        font: UIFont.AlleyFontSystem = .subtitle2,
        alignment: NSTextAlignment = .left
    ) {
        super.init(frame: .zero)
        self.text = title
        self.font = .setFont(font)
        self.textColor = .setColor(textColor)
        self.setLineSpacing(lineSpacing: font.alleyLineHeight)
        self.textAlignment = alignment
    }
    
    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
