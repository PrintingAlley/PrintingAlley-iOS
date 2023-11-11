//
//  AlleyPageViewController.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/29/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import SnapKit
import Then
import RxSwift
import DesignSystem

class AlleyPageViewController: UIViewController {

    
    public var viewControllers: [UIViewController] = []

    
    let disposeBag = DisposeBag()
    
    var viewModel: AlleyPageViewModel!
    
    lazy var input: AlleyPageViewModel.Input = .init()
    
    
    lazy var layer: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layer).then {
        $0.bounces = false
        $0.register(PageTitleCollectionViewCell.self, forCellWithReuseIdentifier: PageTitleCollectionViewCell.identifer)
        $0.delegate = self
        $0.dataSource = self
    }


    lazy var indicaatorBar: UIView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    
    lazy var pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil).then {
        $0.dataSource = self
        $0.delegate = self 
    }
    
    init(viewModel: AlleyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()
        bindViewModel()
    }
    

}

extension AlleyPageViewController {
    
    
    public func setChildren(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        pageViewController.setViewControllers([self.viewControllers[0]], direction: .forward, animated: true)
    
    }
    
    func addSubviews() {
        self.view.addSubviews(collectionView,baseLine,indicaatorBar,pageViewController.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }
    
    func makeConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(58)
        }
        
        baseLine.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(collectionView.snp.bottom)
        }
        
        indicaatorBar.snp.makeConstraints {
            $0.bottom.equalTo(baseLine.snp.bottom)
            $0.height.equalTo(2)
            $0.width.equalTo(APP_WIDTH() / CGFloat(viewControllers.count ))
            $0.left.equalToSuperview()
            
        }
        
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(baseLine.snp.bottom)
            $0.left.right.bottom.equalToSuperview()

        }
        
        
        
    }
    
    func bindViewModel() {
        
        let output = viewModel.transform(input: input)
        
        
        bindCollectionEvent()
        bindConstraints(output: output)
    }
    

    
}





