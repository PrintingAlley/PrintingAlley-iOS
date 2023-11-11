//
//  BookMarkViewController.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxDataSources
import UtilityModule
import BaseFeatureInterface
import BaseFeature


class BookMarkDetailViewController: UIViewController {

    var viewModel: BookMarkDetailViewModel!
    var editModalFactory: any EditModalFactory
    
    let disposeBag = DisposeBag()
    let input = BookMarkDetailViewModel.Input()
    var output: BookMarkDetailViewModel.Output!
    
    lazy var naviTitleView: UIView = UIView()
    lazy var backButton: UIButton = UIButton().then {
    
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }

    lazy var editButton: UIButton = UIButton().then{
        $0.setImage(DesignSystemAsset.Icon.pencil.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    
    lazy var naviTitleLabel: AlleyLabel = AlleyLabel()
    
    
    lazy var countLabel: AlleyLabel = AlleyLabel()
    
    public lazy var layout = AutoHeightCollectionViewLayout().then {
        $0.delegate = self // 이 딜리게이트 받아줘야함
    }
    
    lazy var gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: PinterestCollectionViewCell.identifer)
    }
    
    
    
    init(editModalFactory: EditModalFactory, viewModel: BookMarkDetailViewModel!) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
        self.editModalFactory = editModalFactory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.post(name: .refreshBookMarkGroup, object: nil)
        DEBUG_LOG("\(Self.self) Denit ❌ ")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommonUI()
        addSubviews()
        makeConstraints()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack()
    }
    
}

extension BookMarkDetailViewController {
    
    
    func addSubviews() {
        self.view.addSubviews(naviTitleView, countLabel, gridCollectionView)
        naviTitleView.addSubviews(backButton, naviTitleLabel,editButton)
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
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(naviTitleView.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
        }
        
        gridCollectionView.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(24)
            $0.left.right.bottom.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(24)
        }
        

        
        
    }
    
    func bindViewModel() {
        output = viewModel.transform(input: input)
        bindViewDidLoad(input: input)
        bindBackButton()
        bindEditButton()
        bindRefresh(input: input)
        ///bind Output
        bindDataSource(input: input, output: output)
        bindItemSelected(output: output)
        bindShowToast(input: input, output: output)
    }


}


