//
//  FillterViewController.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import BaseDomainInterface
import UtilityModule
import RxSwift

public protocol FilterViewControllerDelegate: AnyObject {
    func receive(result: [Tag])
}

class FilterViewController: UIViewController {

    lazy var titleLabel: AlleyLabel = AlleyLabel("필터", textColor: .sub(.black), font: .subtitle1)
    lazy var closeButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.downArrow.image, for: .normal)
        $0.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
     
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        $0.register(SecondFilterTableViewCell.self, forCellReuseIdentifier: SecondFilterTableViewCell.identifier)
        $0.register(FilterSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: FilterSectionHeaderView.identifer)
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = . none
        $0.bounces = false
        $0.backgroundColor = .white
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var findButton: UIButton = UIButton().then {
        $0.backgroundColor = DesignSystemAsset.MainBlue.blue500.color
        $0.setTitle("찾아보기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Sub.white.color, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle1)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(tapFind), for: .touchUpInside)
    }
    
    lazy var resetButton: UIButton = UIButton().then {
        $0.setTitle("재설정", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Sub.black.color, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle2)
        $0.setImage(DesignSystemAsset.Icon.reFresh.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(tapRefresh), for: .touchUpInside)
        
    }
    
    lazy var buttonContainerView: UIView = UIView()
    
    var viewModel: FilterViewModel!
    public weak var deleagte: FilterViewControllerDelegate?
    
    let disposeBag = DisposeBag()
    
    private var panGestureRecognizer: UIPanGestureRecognizer!

    init(viewModel: FilterViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()
        bindViewModel()
        bindGesture()
    }
}

extension FilterViewController {
    
    func addSubviews() {
        self.view.addSubviews(titleLabel, closeButton, tableView, buttonContainerView, baseLine)
        self.buttonContainerView.addSubviews(resetButton, findButton)
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.bottom.equalTo(baseLine.snp.top)
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonContainerView.snp.top).offset(-8)
        }
        
        buttonContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(30)
        }
        
        resetButton.snp.makeConstraints {
            
            $0.left.equalToSuperview()
            $0.right.equalTo(findButton.snp.left).offset(-20)
            $0.centerY.equalTo(findButton.snp.centerY)
            $0.height.equalTo(24)
            $0.width.equalTo(68)
        }
        
        findButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    func bindGesture() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func bindViewModel() {
        let input = FilterViewModel.Input()
        let output = viewModel.transform(input: input)
        
        viewModel.dataSource
            .withUnretained(self)
            .subscribe(onNext: { (owner,dataSource) in
                owner.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
    }
}
