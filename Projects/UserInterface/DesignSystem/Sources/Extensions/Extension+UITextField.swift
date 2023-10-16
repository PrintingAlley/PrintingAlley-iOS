//
//  Extension+UITextField.swift
//  DesignSystem
//
//  Created by yongbeomkwak on 10/16/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    public func setPlaceHolder(text:String, textColor: UIColor, font: UIFont.AlleyFontSystem) {
        

        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : textColor, NSAttributedString.Key.font : font.font ])
        
    }
    
}
