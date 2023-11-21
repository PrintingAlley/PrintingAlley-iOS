//
//  Extension+UIView.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 10/19/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import SwiftEntryKit
import DesignSystem

public extension UIView {
    public func showBottomToast(text: String) {
            var attributes = EKAttributes.bottomFloat
            attributes.displayDuration = 2
        attributes.entryBackground = .color(color: EKColor(rgb: 0x000000).with(alpha: 1.0))
            attributes.roundCorners = .all(radius: 20)
            attributes.positionConstraints.verticalOffset = 5
        
            let style = EKProperty.LabelStyle(
                font: .setFont(.body2),
                color: EKColor(rgb: 0xFFFFFF),
                alignment: .center
            )
            let labelContent = EKProperty.LabelContent(
                text: text,
                style: style
            )
            
            let contentView = EKNoteMessageView(with: labelContent)
            contentView.verticalOffset = 10
            SwiftEntryKit.display(entry: contentView, using: attributes)
        }
    
    public func showTopToast(text: String) {
        var attributes = EKAttributes.topToast
            attributes.displayDuration = 2
            attributes.entryBackground = .color(color: EKColor(rgb: 0x000000).with(alpha: 1.0))
            attributes.roundCorners = .all(radius: 20)
            attributes.positionConstraints.verticalOffset = 5
        
            let style = EKProperty.LabelStyle(
                font: .setFont(.body2),
                color: EKColor(rgb: 0xFFFFFF),
                alignment: .center
            )
            let labelContent = EKProperty.LabelContent(
                text: text,
                style: style
            )
            
            let contentView = EKNoteMessageView(with: labelContent)
            contentView.verticalOffset = 10
            SwiftEntryKit.display(entry: contentView, using: attributes)
        }
}
