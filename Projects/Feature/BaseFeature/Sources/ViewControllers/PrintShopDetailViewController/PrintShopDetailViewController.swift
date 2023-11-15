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
    
    let printShopTmp = PrintShopEntity(id: 1, name: "인쇄소", address: "강남구", phone: "행드폰번호", email: "이메일", homepage: "홈페이지", type: "인쇄기획사", printType: "먼데?", afterProcess: "후가공", businessHours: "영업시간", introduction: "소개글", logoImage: "", backgroundImage: "", latitude: "", longitude: "", products: [
        ProductEntity(id: 1, name: "안녕", size: "", paper: "", printType: "타입", afterProcess: "", designer: "", introduction: "하이루", description: "", mainImage: "https://printingstreets.uk/cb59424b-3352-4750-90e0-84131f43718f_28afe2c0-6042-429a-8289-423e4b4a7800_4c7fdc9ad4ec035f858a142d2177531e.png?width=564&height=564", images: [], category: .makeErrorEntity(), printShop: .makeErrorEntity(), tags: [], reviews: [], isBookmarked: false, statusCode: 200, message: ""),
        ProductEntity(id: 1, name: "안녕", size: "", paper: "", printType: "타입", afterProcess: "", designer: "", introduction: "하이루", description: "", mainImage: "https://printingstreets.uk/cb76c11a-9cd4-43c5-99db-8db650172d66_f4049ed7-97c0-4b2c-8214-923041d9115e_57a63cbb4b2434e7c82525485f669477.png?width=800&height=1061", images: [], category: .makeErrorEntity(), printShop: .makeErrorEntity(), tags: [], reviews: [], isBookmarked: false, statusCode: 200, message: ""),
        ProductEntity(id: 1, name: "안녕", size: "", paper: "", printType: "타입", afterProcess: "", designer: "", introduction: "하이루", description: "", mainImage: "https://printingstreets.uk/cb76c11a-9cd4-43c5-99db-8db650172d66_f4049ed7-97c0-4b2c-8214-923041d9115e_57a63cbb4b2434e7c82525485f669477.png?width=800&height=1061", images: [], category: .makeErrorEntity(), printShop: .makeErrorEntity(), tags: [], reviews: [], isBookmarked: false, statusCode: 200, message: "")
    ])

    private let scrollView = UIScrollView()
    
    private lazy var layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
    }

    private lazy var imageCollectionView = makeCollectionView(layout: layout, scrollDirection: .horizontal, delegate: self, dataSource: self).then {
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

    lazy var typeLabel = AlleyLabel("인쇄", textColor: .grey(.grey500), font: .subtitle3) // TODO: - 색상 변경

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
        let vc1 = printShopInfoFactory.makeView(printShop: printShopTmp)
        let vc2 = printShopProductsFactory.makeView(products: printShopTmp.products)

        $0.setChildren([vc1, vc2])
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
        view.addSubviews(scrollView)
        scrollView.addSubviews(imageCollectionView, navigationView, titleLabel, typeLabel, callButton, separateLine, controllerView)
        navigationView.addSubviews(backButton, homeButton)
        controllerView.addSubviews(pageViewController.view)
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
    }
    
    func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }

        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(32)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        homeButton.snp.makeConstraints {
            $0.width.height.equalTo(34)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.centerY.equalTo(backButton)
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
            $0.top.equalTo(typeLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(10)
        }
        
        controllerView.snp.makeConstraints {
            $0.top.equalTo(separateLine.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(pageViewController.view.snp.height)
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
    }
}

// MARK: - Collectionview Delegate
// TODO: - 딜리게이트 분리
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
