//
//  CategorySearchViewController.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import UtilityModule
import BaseFeature
import RxSwift
import RxDataSources
import SnapKit
import Then
import BaseDomainInterface

class CategorySearchViewController: UIViewController {
    
    var dummy: [Dummy] = [ // CollectionView용 더미 이미지 리스트
        Dummy(image: DesignSystemAsset.Logo.tmpCard1.image, title: "Dongseongro Blues Pub Branding"),
        Dummy(image: DesignSystemAsset.Logo.tmpCard2.image, title: "PAGE GALLERIES"),
        Dummy(image: DesignSystemAsset.Logo.tmpCard3.image, title: "Graphics thisisgrey likes"),
        Dummy(image: DesignSystemAsset.Logo.tmpCard4.image, title: "안녕"),
        Dummy(image: DesignSystemAsset.Logo.tmpCard5.image, title: "SPACELOGIC"),
        Dummy(image: DesignSystemAsset.Logo.tmpCard6.image, title: "Dongseongro Blues Pub \nBranding")
    ]
    
    var filterDummy: [ChildrenTagEntity] = [
        ChildrenTagEntity(id: 2, name: "소량인쇄", image: "", parentID: 12, children: []),
        ChildrenTagEntity(id: 3, name: "대량인쇄", image: "", parentID: 12, children: []),
        ChildrenTagEntity(id: 4, name: "대량인쇄", image: "", parentID: 12, children: []),
        ChildrenTagEntity(id: 5, name: "대량인쇄", image: "", parentID: 12, children: []),
        ChildrenTagEntity(id: 6, name: "대량인쇄", image: "", parentID: 12, children: []),
    ]
    
    lazy var filterTags: [Tag] = []

    lazy var naviTitleView: UIView = UIView()
    lazy var backButton: UIButton = UIButton().then {
        
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    lazy var naviTitleLabel: AlleyLabel = AlleyLabel()
    
    lazy var filterButton: UIButton = FilterButton(title: "필터", id: -1, type: .filter, willChangeUI: false).then {
        $0.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
        $0.semanticContentAttribute = .forceRightToLeft //<- 중요
        $0.clipsToBounds = true
    }
    
    lazy var filterCollectionView = makeCollectionView(layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal, delegate: self, dataSource: self).then {
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
        $0.tag = 0
    }
    
    lazy var tableView: UITableView = UITableView().then {
        $0.register(PrintingTableViewCell.self, forCellReuseIdentifier: PrintingTableViewCell.identifier)
        $0.separatorStyle = .none
    }
    
    lazy var layout = AutoHeightCollectionViewLayout().then {
        $0.delegate = self // 이 딜리게이트 받아줘야함
    }
    
    lazy var gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.dataSource = self
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: PinterestCollectionViewCell.identifer)
        $0.tag = 1
    }
    
    lazy var headerView: CategoryEmptyHeaderView = CategoryEmptyHeaderView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: APP_HEIGHT()/2)).then {
        $0.delegate = self
    }

    var viewModel: CategorySearchViewModel!
    
    let disposeBag = DisposeBag()
    
    init(viewModel: CategorySearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        makeConstraints()
        self.naviTitleLabel.setTitle(title: viewModel.title, textColor: .sub(.black), font: .subtitle1, alignment: .center)
        configureCommonUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack()
    }
}

// MARK: - UI 관련 함수
extension CategorySearchViewController {
    func addSubviews() {
//        self.view.addSubviews(naviTitleView, filterButton, tableView)
        view.addSubviews(naviTitleView, filterCollectionView, filterButton, gridCollectionView)
        naviTitleView.addSubviews(backButton, naviTitleLabel)
    }
    
    func makeConstraints() {
        
        naviTitleView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(32)
        }
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        naviTitleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        filterButton.snp.makeConstraints {
            $0.top.equalTo(naviTitleView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(27)
            $0.width.equalTo(67)
            $0.height.equalTo(32)
        }
        
        filterCollectionView.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalTo(naviTitleView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(112)
        }
        
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(filterButton.snp.bottom).offset(16)
//            $0.left.right.bottom.equalToSuperview()
//        }

        gridCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel() {
        let input = CategorySearchViewModel.Input()
        let output = viewModel.transform(input: input)
        
        bindDataSource(output: output)
        
        bindFilterButton()
    }
}
