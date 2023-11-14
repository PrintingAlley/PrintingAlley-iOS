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
import BaseDomainInterface // entity용

final class PrintShopInfoViewController: UIViewController {

    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
        $0.register(PrintShopInfoTableViewCell.self, forCellReuseIdentifier: PrintShopInfoTableViewCell.identifier)
    }
    
    let viewModel: PrintShopInfoViewModel!
    
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
        view.backgroundColor = .red
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

extension PrintShopInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        41
    }
}

extension PrintShopInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrintShopInfoTableViewCell.identifier, for: indexPath) as? PrintShopInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.update(model: viewModel.printShop, index: indexPath.row)
        return cell
    }

}
