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
    let tableViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private let containerScrollView = UIScrollView()

    private lazy var tableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.contentInset = tableViewInsets
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
        $0.register(PrintShopInfoTableViewCell.self, forCellReuseIdentifier: PrintShopInfoTableViewCell.identifier)
    }
    
    private let greyRoundView = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
        $0.setRound(.allCorners, radius: 8)
    }
    
    private let printTypeTitle = AlleyLabel("굵은글씨", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left)
    private let printTypeLabel = AlleyLabel("디지털인쇄, 옵셋인쇄", textColor: .grey(.grey500), font: .body2)
    
    private let afterProcessTitle = AlleyLabel("굵은글씨", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left)
    private let afterProcessLabel = AlleyLabel("후가공 내용", textColor: .grey(.grey500), font: .body2)
    
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
        view.addSubviews(containerScrollView)
        containerScrollView.addSubviews(tableView, greyRoundView)
        greyRoundView.addSubviews(printTypeTitle, printTypeLabel, afterProcessTitle, afterProcessLabel)
    }
    
    private func makeConstraints() {
        containerScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(cellHeight * cellCount + tableViewInsets.top + tableViewInsets.bottom)
        }
        
        greyRoundView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(HORIZON_MARGIN1())
            $0.height.equalTo(250)
            $0.bottom.equalToSuperview().inset(42) // TODO: - 텍스트 업데이트 후 높이 구해서 update
        }
        
        printTypeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        printTypeLabel.snp.makeConstraints {
            $0.top.equalTo(printTypeTitle.snp.bottom)
            $0.leading.equalTo(printTypeTitle)
        }
        
        afterProcessTitle.snp.makeConstraints {
            $0.top.equalTo(printTypeLabel.snp.bottom).offset(16)
            $0.leading.equalTo(printTypeLabel)
        }
        
        afterProcessLabel.snp.makeConstraints {
            $0.top.equalTo(afterProcessTitle.snp.bottom)
            $0.leading.equalTo(afterProcessTitle)
        }
    }
}

extension PrintShopInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
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
