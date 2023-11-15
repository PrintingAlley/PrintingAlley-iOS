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
import BookMarkFeatureInterface

class BookMarkViewController: UIViewController {

    var viewModel: BookMarkViewModel!
    var bookMarkDetailFactory: any BookMarkDetailFactory
    
    var refreshControl = UIRefreshControl().then {
        $0.tintColor = DesignSystemAsset.MainBlue.blue500.color
    }
    let input = BookMarkViewModel.Input()
    
    let disposeBag = DisposeBag()
    
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large).then{
        $0.color = DesignSystemAsset.MainBlue.blue500.color
        $0.hidesWhenStopped = true
        
    }
        
    lazy var naviTitleView: UIView = UIView()
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var backButton: UIButton = UIButton().then {
        
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    
    lazy var editOrDoneButton: UIButton = UIButton()
    
    lazy var deleteButton: UIButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitle("삭제", for: .disabled)
        
        $0.setTitleColor(DesignSystemAsset.Grey.grey300.color, for: .disabled)
        $0.setTitleColor(DesignSystemAsset.Sub.red500.color, for: .normal)
        
        $0.titleLabel?.font = .setFont(.body1)
        
        
        
    }
    
    
    lazy var naviTitleLabel: AlleyLabel = AlleyLabel("저장목록", textColor: .sub(.black), font: .header3, alignment: .center)
    
    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
        $0.sectionInset = UIEdgeInsets(top: 24, left: 16.0, bottom: 20, right: 16.0)
        
        
        $0.itemSize = .init(width: GRID_WIDHT() , height: GRID_HEIGHT())
        
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.refreshControl = refreshControl
        $0.register(BookMarkCollectionViewCell.self, forCellWithReuseIdentifier: BookMarkCollectionViewCell.identifer)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        
    }
    

    
    init(bookMarkDetailFactory: BookMarkDetailFactory ,viewModel: BookMarkViewModel!) {
        self.viewModel = viewModel
        self.bookMarkDetailFactory = bookMarkDetailFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
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

extension BookMarkViewController {
    func addSubviews() {
        self.view.addSubviews(naviTitleView, collectionView, indicator, baseLine)
        naviTitleView.addSubviews(backButton, naviTitleLabel,deleteButton, editOrDoneButton)
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
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(naviTitleView.snp.bottom).offset(19)
        }
        
        
        deleteButton.snp.makeConstraints {
            $0.width.height.equalTo(29)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(editOrDoneButton.snp.left).offset(-10)
        }
        
        editOrDoneButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(29)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(baseLine.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        
        
    }
    
    func bindViewModel() {
       
        let output = self.viewModel.transform(input: input)
        
        ///bind Input
        bindEditState(input: input)
        bindStateInputWithButton(input: input)
        bindViewDidLoad(input: input)
        bindRefresh(input: input)
        bindTapDelete(input: input)
        bindRefreshControl(input: input)
        
        
        ///bind Output
        bindDataSource(input:input, output:output)
        bindIndexOfSelectedItem(output: output)
        bindBackButton()
        bindResult(input: input, output: output)
        bindIndicator(output: output)
        bindItemSelected(output: output)
    }
    
  

}
