//
//  Extension+UIView.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/04.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public extension UIView {
    // use: setRound([.allCorners], radius: 22)
    func setRound(_ corners: UIRectCorner, radius: CGFloat) {
        self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    // use: addSubview(firstView, secondView)
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    // use: myView.addTapGesture(target: self, action: #selector(action))
    func addTapGesture(target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
