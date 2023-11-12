//
//  ProductDetailViewController.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import DesignSystem
import BaseFeatureInterface
import FloatingPanel
import RxSwift

class ProductDetailViewController: UIViewController {


    lazy var tableView: UITableView = UITableView().then {
        $0.register(ProductDetailTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ProductDetailTableHeaderView.identifer)
        $0.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: ProductDetailTableViewCell.identifer)
        $0.bounces = false
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
    }
    
    lazy var backButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.backWhite.image, for: .normal)
        $0.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
    }
    
    lazy var homeButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.whiteHome.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }
    
    var viewModel: ProductDetailViewModel!
    var input: ProductDetailViewModel.Input = .init()
    lazy var output = viewModel.transform(input: input)
    var bookMarkBottomSheetFactory: any BookMarkBottomSheetFactory
    
    var fpc: FloatingPanelController!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()
        bindViewModel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSwipeBack()
    }

    
    init(bookMarkBottomSheetFactory: BookMarkBottomSheetFactory, viewModel: ProductDetailViewModel) {

        self.viewModel = viewModel
        self.bookMarkBottomSheetFactory = bookMarkBottomSheetFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

extension ProductDetailViewController {
    func addSubviews() {
        self.view.addSubviews(tableView,backButton,homeButton)
    }
    
    func makeConstraints() {
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        
        self.backButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
        }
        
        self.homeButton.snp.makeConstraints {
            $0.width.height.equalTo(34)
            $0.right.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.centerY.equalTo(backButton)
        }
    }
    
    
    @objc func moveBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pop() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func bindViewModel() {

     
        bindToast(output: output)
        bindDataSource(output: output)
        bindFetchData()
        
        
    }
}


