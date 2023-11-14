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
        $0.backgroundColor = .setColor(.sub(.white))
        $0.bounces = false
        $0.register(PageTitleCollectionViewCell.self, forCellWithReuseIdentifier: PageTitleCollectionViewCell.identifer)
        $0.delegate = self
        $0.dataSource = self
    }

    lazy var indicatorBar: UIView = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey800))
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100))
    }
    
    lazy var pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil).then {
        $0.dataSource = self
        $0.delegate = self
    }
    
    init(viewModel: AlleyPageViewModel) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
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
        view.addSubviews(collectionView, baseLine, indicatorBar, pageViewController.view)
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
            $0.height.equalTo(0.8)
            $0.centerY.equalTo(collectionView.snp.bottom)
        }
        
        indicatorBar.snp.makeConstraints {
            $0.bottom.equalTo(baseLine.snp.bottom)
            $0.height.equalTo(2)
            $0.width.equalTo(APP_WIDTH() / CGFloat(viewControllers.count))
            $0.left.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(baseLine.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        } // TODO: - 페이지컨트롤러 레이블 레이아웃 맞추기..
    }
    
    func bindViewModel() {
        let output = viewModel.transform(input: input)
        
        bindCollectionEvent()
        bindConstraints(output: output)
    }
}
