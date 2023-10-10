//
//  MainTabBarController.swift
//  MainTabFeatureInterface
//
//  Created by 박의서 on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import MyPageFeatureInterface

public class MainTabBarController: UITabBarController {
    private let myPageFactory: any MyPageFactory
    
    init(myPageFactory: MyPageFactory) {
        self.myPageFactory = myPageFactory
    }
    
    private lazy var tabbarControllers: [UIViewController] = {
        let viewControllers = [
            myPageFactory.makeView() // ??
        ]
        return viewControllers
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers(tabbarControllers, animated: true)
    }
}
