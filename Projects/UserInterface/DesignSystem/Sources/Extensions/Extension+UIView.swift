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
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
    }
    
    // use: addSubview(firstView, secondView)
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
