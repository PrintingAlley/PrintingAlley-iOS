//  Extension+UIViewController.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

public extension UIViewController {
    var wrapNavigationController: UINavigationController {
        UINavigationController(rootViewController: self)
    }
    
     public func configureCommonUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        if #available(iOS 15.0, *) {
            let tableViews = self.view.subviews.map { $0 as? UITableView }.compactMap { $0 }
            tableViews.forEach {
                $0.sectionHeaderTopPadding = 0
            }
        }
        
         self.view.backgroundColor = DesignSystemAsset.Sub.white.color
    }

    ///viewDidAppear에 명시
    public func configureSwipeBack() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil // 현재 탭에서 화면이동이 일어날 시 , 빠져나올 때 swipe로 이동
    }
    
    /*
     
     public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            configureSwipeBack()
            
        }

     */
}
