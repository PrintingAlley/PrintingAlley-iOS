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
import RxSwift
import BaseDomainInterface // 임시 entity용
import BaseFeatureInterface
import PrintShopDomainInterface

class PrintShopDetailViewController: UIViewController {
    
    let printShopInfoFactory: PrintShopInfoFactory!
    let printShopProductsFactory: PrintShopProductsFactory!
    
    private let viewModel: PrintShopDetailViewModel!
    
    let input = PrintShopDetailViewModel.Input()
    lazy var output = viewModel.transform(input: input)
    
    let disposeBag = DisposeBag()
    
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large).then{
        $0.color = DesignSystemAsset.MainBlue.blue500.color
        $0.hidesWhenStopped = true
    }
    
    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
    }

    public lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.isPagingEnabled = true // 컨텐츠 만큼 스크롤
        $0.register(PrintShopPhotosCollectionViewCell.self, forCellWithReuseIdentifier: PrintShopPhotosCollectionViewCell.identifier)
    }
    
    private lazy var navigationView = UIView()
    
    lazy var backButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.backWhite.image, for: .normal)
        $0.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
    }
    
    lazy var homeButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.whiteHome.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }

    lazy var titleLabel = AlleyLabel("정다운 인쇄소", textColor: .sub(.black), font: .header3).then {
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 1
    }

    lazy var typeLabel = AlleyLabel("인쇄", textColor: .yellow(.yellow600), font: .subtitle3) // TODO: - 색상 변경

    lazy var callButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.callBlack.image, for: .normal)
        $0.setTitle("전화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .setFont(.body2)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 24, right: 3)
        $0.alignTextBelow()
    }
    
    private let separateLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
    }
    
    private let controllerView = UIView().then {
        $0.backgroundColor = .brown
    }
    
    lazy var pageViewController = AlleyPageViewController(viewModel: AlleyPageViewModel(titles: ["정보", "작업"])).then {
        
        $0.setChildren([UIViewController(), UIViewController()])
    }

    let tmp: [String] = ["tmpPrintShop", "tmpPrintShop", "tmpPrintShop"]
    
    init(printShopInfoFactory: PrintShopInfoFactory, printShopProductsFactory: PrintShopProductsFactory, viewModel: PrintShopDetailViewModel) {
        self.printShopInfoFactory = printShopInfoFactory
        self.printShopProductsFactory = printShopProductsFactory
        self.viewModel = viewModel
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
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSwipeBack()
    }
}

// MARK: - UI 함수들
extension PrintShopDetailViewController {
    func addSubviews() {
        view.addSubviews(imageCollectionView, navigationView, titleLabel, typeLabel, callButton, separateLine, controllerView)
        navigationView.addSubviews(backButton, homeButton)
        controllerView.addSubviews(pageViewController.view)
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }
    
    func makeConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(44)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(22)
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        homeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.width.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(209)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.lessThanOrEqualTo(281)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
        }
        
        callButton.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(20)
            $0.width.equalTo(30)
            $0.height.equalTo(57)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        separateLine.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(10)
        }
        
        controllerView.snp.makeConstraints {
            $0.top.equalTo(separateLine.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view)
        }

        pageViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}

extension PrintShopDetailViewController {
    func bindViewModel() {
        bindButton()
        bindDataSource(output: output)
        bindIndicator(output: output)
    }
    
    @objc func moveBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pop() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func update(model: PrintShopEntity) {
        self.titleLabel.text = model.name
        self.typeLabel.text = model.type
        
        let vc1 = printShopInfoFactory.makeView(printShop: output.dataSource.value)
        let vc2 = printShopProductsFactory.makeView(products: output.dataSource.value.products)
        
        self.pageViewController.setChildren([vc1, vc2])
    }
}

// MARK: - Collectionview Delegate
extension PrintShopDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: APP_WIDTH(), height: 251)
    }
}
