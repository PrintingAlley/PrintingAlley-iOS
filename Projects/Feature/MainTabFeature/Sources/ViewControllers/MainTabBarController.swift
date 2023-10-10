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
    // 폰트 및 이미지 적용
    private let tabBarItems: [UITabBarItem] = {
        let items = [
        UITabBarItem(title: "홈", image: UIImage(systemName: "home"), selectedImage: UIImage(systemName: "heart")),
        UITabBarItem(title: "내 주변", image: UIImage(systemName: "home"), selectedImage: UIImage(systemName: "heart")),
        UITabBarItem(title: "MY", image: UIImage(systemName: "home"), selectedImage: UIImage(systemName: "heart"))
        ]
        return items
    }()
    
    private lazy var tabbarControllers: [UIViewController] = {
        let viewControllers = [
            myPageFactory.makeView(),
            myPageFactory.makeView(),
            myPageFactory.makeView()
        ]
        return viewControllers
    }()
    
    init(myPageFactory: MyPageFactory) {
        self.myPageFactory = myPageFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .brown
        configureUI()
    }
}

extension MainTabBarController {
    private func configureUI() {
        for (index, item) in tabBarItems.enumerated() {
            tabbarControllers[index].tabBarItem = item
        }
        
        setViewControllers(tabbarControllers, animated: true)
    }
}
