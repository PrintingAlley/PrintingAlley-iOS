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
    public func showToast(text: String) {
            var attributes = EKAttributes.bottomFloat
            attributes.displayDuration = 2
            attributes.entryBackground = .color(color: EKColor(rgb: 0x101828).with(alpha: 0.8))
            attributes.roundCorners = .all(radius: 20)
            
            let style = EKProperty.LabelStyle(
                font: .setFont(.body1),
                color: EKColor(rgb: 0xFCFCFD),
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
