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
import BaseDomainInterface

final class PrintShopInfoViewController: UIViewController {
    
    let cellHeight: CGFloat = 41
    let cellCount: CGFloat = 4
    let tableViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private let scrollView = UIScrollView()

    private lazy var tableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.contentInset = tableViewInsets
        $0.separatorStyle = .none
        $0.backgroundColor = .setColor(.sub(.white))
        $0.delegate = self
        $0.dataSource = self
        $0.register(PrintShopInfoTableViewCell.self, forCellReuseIdentifier: PrintShopInfoTableViewCell.identifier)
    }
    
    private let introductionIcon = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.dotTextBubble.image
        $0.contentMode = .scaleToFill
    }
    
    private let introductionLabel = AlleyLabel("-", textColor: .sub(.black), font: .body2).then {
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private let separateLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100))
    }
    
    private let greyRoundView = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
        $0.setRound(.allCorners, radius: RADIUS1())
    }
    
    private let printTypeTitle = AlleyLabel("인쇄 방식", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left).then {
        $0.sizeToFit()
    }
    public lazy var printTypeLabel = AlleyLabel("-", textColor: .grey(.grey500), font: .body2).then {
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    
    private let afterProcessTitle = AlleyLabel("후가공", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left).then {
        $0.sizeToFit()
    }
    public lazy var afterProcessLabel = AlleyLabel("-", textColor: .grey(.grey500), font: .body2).then {
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    
    private let afterProcessBindingTitle = AlleyLabel("후가공(제본)", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left).then {
        $0.sizeToFit()
    }
    public lazy var afterProcessBindingLabel = AlleyLabel("-", textColor: .grey(.grey500), font: .body2).then {
        $0.sizeToFit()
        $0.numberOfLines = 0
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
        update(model: viewModel.printShop)
    }
}

// MARK: - UI 관련
extension PrintShopInfoViewController {
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubviews(tableView, introductionIcon, introductionLabel, separateLine, greyRoundView)
        greyRoundView.addSubviews(printTypeTitle, printTypeLabel, afterProcessTitle, afterProcessLabel, afterProcessBindingTitle, afterProcessBindingLabel)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(cellHeight * cellCount + tableViewInsets.top + tableViewInsets.bottom)
        }
        introductionIcon.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        introductionLabel.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(7)
            $0.leading.equalTo(introductionIcon.snp.trailing).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(HORIZON_MARGIN1())
        }
        
        separateLine.snp.makeConstraints {
            $0.bottom.equalTo(introductionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(HORIZON_MARGIN1())
            $0.height.equalTo(0.8)
        }
        
        greyRoundView.snp.makeConstraints {
            $0.top.equalTo(separateLine.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(HORIZON_MARGIN1())
            $0.bottom.equalToSuperview().inset(42)
        }
        
        printTypeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        printTypeLabel.snp.makeConstraints {
            $0.top.equalTo(printTypeTitle.snp.bottom)
            $0.leading.equalTo(printTypeTitle)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        afterProcessTitle.snp.makeConstraints {
            $0.top.equalTo(printTypeLabel.snp.bottom).offset(16)
            $0.leading.equalTo(printTypeLabel)
        }
        
        afterProcessLabel.snp.makeConstraints {
            $0.top.equalTo(afterProcessTitle.snp.bottom)
            $0.leading.equalTo(afterProcessTitle)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        afterProcessBindingTitle.snp.makeConstraints {
            $0.top.equalTo(afterProcessLabel.snp.bottom).offset(16)
            $0.leading.equalTo(afterProcessTitle)
        }
        
        afterProcessBindingLabel.snp.makeConstraints {
            $0.top.equalTo(afterProcessBindingTitle.snp.bottom)
            $0.leading.equalTo(afterProcessBindingTitle)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func update(model: PrintShopEntity) {
        
        introductionLabel.text = model.introduction
        printTypeLabel.text = model.printType.isEmpty ? "-" : model.printType
        afterProcessLabel.text = model.afterProcess.isEmpty ? "-" : model.afterProcess
        afterProcessBindingLabel.text = model.afterProcessBinding.isEmpty ? "-" : model.afterProcessBinding
    }
}
