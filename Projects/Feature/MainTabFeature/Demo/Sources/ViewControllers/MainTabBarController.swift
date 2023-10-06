//
//  MainTabBarController.swift
//  MainTabFeatureInterface
//
//  Created by 박의서 on 2023/10/06.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import MyPageFeature
import Utili

public class MainTabBarController: UITabBarController {
    
    private lazy var tabbarControllers: [UIViewController] = {
        let viewControllers = [
            myPageComponent.makeView().wrapNavigationController
        ]
        return viewControllers
    }()
    
    private var myPageComponent: MyPageComponent!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
