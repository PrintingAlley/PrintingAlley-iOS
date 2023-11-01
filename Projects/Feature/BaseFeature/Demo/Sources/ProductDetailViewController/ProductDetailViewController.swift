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

class ProductDetailViewController: UIViewController {


    lazy var tableView: UITableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(ProductDetailTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ProductDetailTableHeaderView.identifer)
        $0.bounces = true
    }
    
    lazy var backButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.backWhite.image, for: .normal)
        $0.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSwipeBack()
    }
    
    init() {
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
        self.view.addSubviews(tableView,backButton)
    }
    
    func makeConstraints() {
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.backButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
        }
    }
    
    @objc func moveBack() {
        self.navigationController?.popViewController(animated: true)
    }
}


