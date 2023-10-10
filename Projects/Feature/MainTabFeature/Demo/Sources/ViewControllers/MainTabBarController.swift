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
    private var myPageFactory: any MyPageFactory
    
    init(myPageFactory: MyPageFactory) {
        self.myPageFactory = myPageFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tabbarControllers: [UIViewController] = {
        let viewControllers = [
            myPageFactory.makeView() // viewController 반환
        ]
        return viewControllers
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .brown
        setViewControllers(tabbarControllers, animated: true)
    }
}
