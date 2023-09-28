//  Extension+UIViewController.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    var wrapNavigationController: UINavigationController {
        UINavigationController(rootViewController: self)
    }
}
