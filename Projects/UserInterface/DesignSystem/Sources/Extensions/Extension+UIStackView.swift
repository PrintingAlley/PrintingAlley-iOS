//
//  Extension+UIStackView.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/10/07.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public extension UIStackView {

    // use: addArrangedSubview(firstView, secondView)
    func addArrangedSubview(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
