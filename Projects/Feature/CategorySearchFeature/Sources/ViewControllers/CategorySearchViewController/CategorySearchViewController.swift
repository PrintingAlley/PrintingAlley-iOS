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
import CategorySearchFeatureInterface
import BaseDomainInterface
import BaseFeatureInterface

class CategorySearchViewController: UIViewController {
    
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large).then {
        $0.color = DesignSystemAsset.MainBlue.blue500.color
        $0.hidesWhenStopped = true
        
    }
    
    lazy var emptyHeaderView = CategoryEmptyHeaderView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: APP_HEIGHT())).then {
        $0.isUserInteractionEnabled = true
        $0.delegate = self
    }

    lazy var naviTitleView: UIView = UIView()
    lazy var backButton: UIButton = UIButton().then {
        
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    lazy var naviTitleLabel: AlleyLabel = AlleyLabel()
    
    private let opacityView = UIView().then {
        $0.backgroundColor = .setColor(.sub(.white)).withAlphaComponent(0.3)
    }

    lazy var filterButton: UIButton = FilterButton(title: "필터", id: -1, type: .filter, willChangeUI: false).then {
        $0.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
        $0.semanticContentAttribute = .forceRightToLeft //<- 중요
        $0.clipsToBounds = true
    }
    
    lazy var filterCollectionView = makeCollectionView(layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal, delegate: self, dataSource: self).then {
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        $0.tag = 0
    }
    
    lazy var tableView: UITableView = UITableView().then {
        $0.register(PrintingTableViewCell.self, forCellReuseIdentifier: PrintingTableViewCell.identifier)
        $0.separatorStyle = .none
    } // 지워야함
    
    public lazy var layout = AutoHeightCollectionViewLayout().then {
        $0.delegate = self // 이 딜리게이트 받아줘야함
    }
    
    lazy var gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: PinterestCollectionViewCell.identifer)
        $0.tag = 1
    }
    
    lazy var headerView: CategoryEmptyHeaderView = CategoryEmptyHeaderView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: APP_HEIGHT()/2)).then {
        $0.delegate = self
    }
    
    var viewModel: CategorySearchViewModel!
    
    let input = CategorySearchViewModel.Input()
    lazy var output = viewModel.transform(input: input)
    
    var filterFactory: any FilterFactory
    
    var productDetailFactory: any ProductDetailFactory

    let disposeBag = DisposeBag()
    
    init(filterFactory: FilterFactory, productDetailFactory: ProductDetailFactory, viewModel: CategorySearchViewModel) {
        self.filterFactory = filterFactory
        self.productDetailFactory = productDetailFactory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        
        let gradient = CAGradientLayer()
        gradient.frame = opacityView.frame
        gradient.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        opacityView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack()
    }
}

extension CategorySearchViewController {
    func addSubviews() {
        view.addSubviews(naviTitleView, filterCollectionView, opacityView, filterButton, gridCollectionView, indicator)
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
            $0.width.equalTo(67)
            $0.height.equalTo(32)
            $0.right.equalToSuperview().inset(27)
        }
        
        filterCollectionView.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.top.equalTo(naviTitleView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(112 - filterCollectionView.contentInset.right)
        }
        
        opacityView.snp.makeConstraints {
            $0.top.height.equalTo(filterButton)
            $0.trailing.equalTo(filterCollectionView)
            $0.width.equalTo(filterCollectionView.contentInset.right)
        }
        
        gridCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
        bindBackEvent()
        bindDataSource(output: output)
        bindIndicator(output: output)
        bindFilterButton()
        bindItemSelected()
        bindGridView()
        input.pageID.accept(1)

    }
    
    func bindBackEvent() {
        backButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { (owner, _) in
                owner.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
