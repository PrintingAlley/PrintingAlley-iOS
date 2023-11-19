//
//  PrintShopInfoViewController.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/13.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import DesignSystem

final class PrintShopInfoViewController: UIViewController {
    
    let cellHeight: CGFloat = 41
    let cellCount: CGFloat = 5
    let tableViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 42, right: 0)
    
    private lazy var footerView = PrintShopDetailFooterView().then {
        $0.update(model: viewModel.printShop)
    }

    private lazy var tableView = UITableView().then {
        $0.contentInset = tableViewInsets
        $0.separatorStyle = .none
        $0.backgroundColor = .setColor(.sub(.white))
        $0.delegate = self
        $0.dataSource = self
        $0.register(PrintShopInfoTableViewCell.self, forCellReuseIdentifier: PrintShopInfoTableViewCell.identifier)
        $0.tableFooterView = footerView
    }
    
    public let viewModel: PrintShopInfoViewModel!
    
    init(viewModel: PrintShopInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        DEBUG_LOG("\(Self.self) Init ✅ ")
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
}

// MARK: - UI 관련
extension PrintShopInfoViewController {
    private func addSubviews() {
        view.addSubviews(tableView)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
