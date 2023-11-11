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
    
    lazy var afterVc = afterSearchFactory.makeView(dataSource: [])
    
    var contentView: UIView! = UIView()
    
    let searchBar = SearchBar()
    
    init(viewModel: SearchViewModel!, afterSearchFactory: AfterSearchFactory) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
        self.viewModel = viewModel
        self.afterSearchFactory = afterSearchFactory
        super.init(nibName: nil, bundle: nil)
        self.add(asChildViewController: afterVc)
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
    private func addSubviews() {
        view.addSubviews(searchBar, contentView)
    }
    
    private func makeConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
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
