//
//  ContainerViewType.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/10/01.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public protocol ContainerViewType {
    var contentView: UIView! {get set}
}

public extension ContainerViewType where Self: UIViewController {
    
    func add(asChildViewController viewController: UIViewController) {

        addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        viewController.view.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }

    func remove(asChildViewController viewController: UIViewController) {

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
