//
//  MainTabBarController.swift
//  MainTabFeatureInterface
//
//  Created by 박의서 on 2023/10/05.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import MyPageFeatureInterface
import HomeFeatureInterface
import SearchFeatueInterface
import UtilityModule

public class MainTabBarController: UITabBarController {
    private var myPageFactory: any MyPageFactory
    private var homeFactory: any HomeFactory
    private var searchFactory: any SearchFactory

    private lazy var tabbarControllers: [UIViewController] = {
        let viewControllers = [
            homeFactory.makeView().wrapNavigationController,
            searchFactory.makeView().wrapNavigationController,
            myPageFactory.makeView().wrapNavigationController
        ]
        return viewControllers
    }()
    
    private let tabBarItems: [UITabBarItem] = {
        let items = [
            UITabBarItem(title: "홈", image: DesignSystemAsset.BottomTabIcon.defaultHome.image.withRenderingMode(.alwaysOriginal), selectedImage: DesignSystemAsset.BottomTabIcon.selectedHome.image.withRenderingMode(.alwaysOriginal)),
            UITabBarItem(title: "인쇄사 찾기", image: DesignSystemAsset.BottomTabIcon.defaultSearch.image.withRenderingMode(.alwaysOriginal), selectedImage: DesignSystemAsset.BottomTabIcon.selectedSearch.image.withRenderingMode(.alwaysOriginal)),
            UITabBarItem(title: "나의 골목", image: DesignSystemAsset.BottomTabIcon.defaultPerson.image.withRenderingMode(.alwaysOriginal), selectedImage: DesignSystemAsset.BottomTabIcon.selectedPerson.image.withRenderingMode(.alwaysOriginal))
        ]
        
        return items
    }()

    init(myPageFactory: MyPageFactory, homeFactory: HomeFactory, searchFactory: SearchFactory) {
        self.myPageFactory = myPageFactory
        self.homeFactory = homeFactory
        self.searchFactory = searchFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        styleTabBar()
        configureUI()
    }
    
//    public override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tabBar.frame.size.height = 80
//        tabBar.frame.origin.y = view.frame.height - 80
//    }
}

extension MainTabBarController {
    private func configureUI() {
        for (index, item) in tabBarItems.enumerated() {
            tabbarControllers[index].tabBarItem = item
        }
        setViewControllers(tabbarControllers, animated: true)
    }
    
    private func styleTabBar() {
        let normalAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.setFont(.body3),
            NSAttributedString.Key.foregroundColor: UIColor.setColor(.grey(.grey600))
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.setColor(.grey(.grey1000))
        ]
        self.tabBar.backgroundColor = .setColor(.sub(.white))
        self.tabBar.layer.borderColor = UIColor.setColor(.grey(.grey100)).cgColor
        self.tabBar.layer.borderWidth = 1.0
        for item in tabBarItems {
            item.setTitleTextAttributes(normalAttributes, for: .normal)
            item.setTitleTextAttributes(selectedAttributes, for: .selected)
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        }
        
        self.tabBar.tintColor =  DesignSystemAsset.Grey.grey1000.color  // 선택된 탭바 아이템 색 변경
    }
}
