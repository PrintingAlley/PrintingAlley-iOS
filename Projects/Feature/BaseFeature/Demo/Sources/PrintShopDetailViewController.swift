//
//  PrintShopDetailViewController.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/29/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import DesignSystem

class PrintShopDetailViewController: UIViewController {

    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
    
    }
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        
        $0.register(PrintShopPhotosCollectionViewCell.self, forCellWithReuseIdentifier: PrintShopPhotosCollectionViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self
        $0.isPagingEnabled = true // 컨텐츠 만큼 스크롤
    }
    
    lazy var naviTitleView: UIView = UIView()
    
    lazy var backButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
    }
    
    lazy var headerView: UIView = UIView()
    lazy var titleLabel: AlleyLabel = AlleyLabel("정다운 인쇄소", textColor: .sub(.black), font: .subtitle1)
    lazy var subTitleLabel: AlleyLabel = AlleyLabel("인쇄", textColor: .grey(.grey500), font: .subtitle3)
    lazy var callButton: UIButton = UIButton().then{
        $0.setImage(DesignSystemAsset.Icon.callBlack.image, for: .normal)
        $0.setTitle("전화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .setFont(.body2)
        $0.alignTextBelow()
        
    }
    
    lazy var containerView: UIView = UIView()
    
    lazy var pageViewController: AlleyPageViewController = AlleyPageViewController(viewModel: AlleyPageViewModel(titles: ["정보","라뷰"])).then{

        let vc1 = UIViewController()
        
        
        let vc2 = UIViewController()
        
        vc2.view.backgroundColor = .green
        
        $0.setChildren([vc1,vc2])
    }
    

    
    let tmp: [String] = ["tmpPrintShop","tmpPrintShop","tmpPrintShop"]
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //aconfigureCommonUI()
        addSubviews()
        makeConstraints()
        view.backgroundColor = .blue

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSwipeBack()
    }
    

}


extension PrintShopDetailViewController {
    func addSubviews() {
        self.view.addSubviews(collectionView,naviTitleView,headerView,containerView)
        self.naviTitleView.addSubview(backButton)
        self.headerView.addSubviews(titleLabel,subTitleLabel,callButton)
        self.containerView.addSubviews(pageViewController.view)
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }
    
    func makeConstraints() {
        naviTitleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            $0.height.equalTo(32)
            $0.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(251)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(24)
    
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        callButton.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(48)
            $0.top.equalTo(titleLabel.snp.top)
            $0.right.equalToSuperview().inset(31)
        }
        
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        
        
        
    }
}


extension PrintShopDetailViewController: UICollectionViewDelegate {
    
}


extension PrintShopDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: APP_WIDTH(), height: 251)
    }
}

extension PrintShopDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tmp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrintShopPhotosCollectionViewCell.identifier, for: indexPath) as? PrintShopPhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.update(id: tmp[indexPath.row])
        
        return cell
    }
    
    
}
