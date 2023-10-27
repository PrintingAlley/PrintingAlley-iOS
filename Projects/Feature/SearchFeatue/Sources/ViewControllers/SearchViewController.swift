//
//  SearchViewController.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/16.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DesignSystem
import UtilityModule
import RxCocoa
import RxSwift
import RxDataSources
import BaseFeatureInterface
import SearchFeatueInterface

final class SearchViewController: UIViewController, ContainerViewType {
    private var viewModel: SearchViewModel!
    
    let disposeBag = DisposeBag()
    let input = SearchViewModel.Input()
    
    var afterSearchFactory: AfterSearchFactory!
    var beforeSearchFactory: BeforeSearchFactory!
    
    // 지울 필요 있는 변수 ..
    lazy var beforeVc = beforeSearchFactory.makeView()
    lazy var afterVc = afterSearchFactory.makeView(dataSource: [])
    
    var contentView: UIView! = UIView()
    
    private let navigationBar = UIView()
    
    private lazy var backButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.addTarget(self, action: #selector(touchBackbtn), for: .touchUpInside)
    }
    
    let searchBar = SearchBar()
    
    init(viewModel: SearchViewModel!, beforeSearchFactory: BeforeSearchFactory, afterSearchFactory: AfterSearchFactory) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
        self.viewModel = viewModel
        self.beforeSearchFactory = beforeSearchFactory
        self.afterSearchFactory = afterSearchFactory
        super.init(nibName: nil, bundle: nil)
        self.add(asChildViewController: beforeVc)
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommonUI()
        addSubviews()
        makeConstraints()
        setKeyboardDown()
        bindViewModel()
    }
}

// MARK: - 네트워크 관련 함수들
extension SearchViewController {
    private func bindViewModel() {
        let output = viewModel.transform(input: input)
        bindUIEvent(input: input)
        bindDataSource(input: input, output: output)
    }
}

// MARK: - UI 관련 함수들
extension SearchViewController {
    func changeToAfterVC() {
        UIView.animate(withDuration: 0.4) {
            self.remove(asChildViewController: self.beforeVc)
            self.add(asChildViewController: self.afterVc)
        }
    }
    
    func changeToBeforeVC() {
        UIView.animate(withDuration: 0.4) {
            self.remove(asChildViewController: self.afterVc)
            self.add(asChildViewController: self.beforeVc)
        }
    }
    
    private func addSubviews() {
        view.addSubviews(navigationBar, contentView)
        navigationBar.addSubviews(backButton, searchBar)
    }
    
    private func makeConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(32)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.width.equalTo(317)
            $0.height.equalTo(52)
            $0.centerY.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setKeyboardDown() {
        let keyboardDownGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(keyboardDownGesture)
    }
}

// MARK: - Objc 함수
extension SearchViewController {
    @objc
    private func touchBackbtn() {
        self.navigationController?.popViewController(animated: true)
    }
}
