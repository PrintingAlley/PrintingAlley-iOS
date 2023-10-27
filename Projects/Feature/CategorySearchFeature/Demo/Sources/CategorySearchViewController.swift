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


class CategorySearchViewController: UIViewController {

    
    lazy var naviTitleView: UIView = UIView()
    lazy var backButton: UIButton = UIButton().then {
        
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    lazy var naviTitleLabel: AlleyLabel = AlleyLabel()
    
    lazy var filterButton: UIButton = UIButton().then {
        $0.setTitle("필터", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .setFont(.body1)
        
        $0.setImage(DesignSystemAsset.Icon.filter.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
        $0.semanticContentAttribute = .forceRightToLeft//<- 중요
        $0.imageEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 0) //<- 중요
        
        $0.backgroundColor = DesignSystemAsset.MainBlue.blue500.color
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    lazy var tableView: UITableView = UITableView().then {
        $0.register(PrintingTableViewCell.self, forCellReuseIdentifier: PrintingTableViewCell.identifier)
        $0.separatorStyle = .none
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
        self.naviTitleLabel.setTitle(title: viewModel.title, textColor: .sub(.black), font: .subtitle1,alignment: .center)
        configureCommonUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack()
    }
    


    
}

extension CategorySearchViewController {
    func addSubviews() {
        self.view.addSubviews(naviTitleView,filterButton,tableView)
        
        naviTitleView.addSubviews(backButton,naviTitleLabel)
        
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
            $0.width.equalTo(67)
            $0.height.equalTo(32)
            $0.top.equalTo(naviTitleView.snp.bottom).offset(16)
            $0.right.equalToSuperview().inset(27)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(filterButton.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        let input = CategorySearchViewModel.Input()
        let output = viewModel.transform(input: input)
        
        bindDataSource(output: output)
        
        bindFilterButton()
        
    }
}
