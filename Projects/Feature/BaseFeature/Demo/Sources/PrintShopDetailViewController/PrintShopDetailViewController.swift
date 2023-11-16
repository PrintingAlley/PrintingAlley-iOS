//
//  PrintShopDetailViewController.swift
//  BaseFeature
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

    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .lightGray
    }
    
    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
    }

    private lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.dataSource = self
        $0.delegate = self
        $0.isPagingEnabled = true // 컨텐츠 만큼 스크롤
        $0.register(PrintShopPhotosCollectionViewCell.self, forCellWithReuseIdentifier: PrintShopPhotosCollectionViewCell.identifier)
    }
    
    private lazy var navigationView = UIView()
    
    private lazy var backButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
    }
    
    private lazy var titleView = UIView().then {
        $0.backgroundColor = .setColor(.sub(.white))
    }

    lazy var titleLabel = AlleyLabel("정다운 인쇄소", textColor: .sub(.black), font: .header3)

    lazy var introduction = AlleyLabel("인쇄", textColor: .grey(.grey500), font: .subtitle3) 

    lazy var callButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.callBlack.image, for: .normal)
        $0.setTitle("전화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .setFont(.body2)
        $0.alignTextBelow()
    }
    
    private let separateLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
    }
    
    private let controllerView = UIView()
    
    lazy var pageViewController = AlleyPageViewController(viewModel: AlleyPageViewModel(titles: ["정보", "작업"])).then {

        let vc1 = UIViewController()
        let vc2 = UIViewController()
        
        vc2.view.backgroundColor = .green
        $0.setChildren([vc1, vc2])
    }

    let tmp: [String] = ["tmpPrintShop", "tmpPrintShop", "tmpPrintShop"]
        
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
        configureCommonUI()
        addSubviews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSwipeBack()
    }
}

extension PrintShopDetailViewController {
    func addSubviews() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(imageCollectionView, navigationView, titleView, separateLine, controllerView)
        navigationView.addSubview(backButton)
        titleView.addSubviews(titleLabel, introduction, callButton)
        controllerView.addSubviews(pageViewController.view)
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            $0.height.equalTo(32)
            $0.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(251)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(168)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        introduction.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        callButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        separateLine.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(10)
        }
        
        controllerView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
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
