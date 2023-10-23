//
//  SearchViewController.swift
//  SearchFeatueDemo
//
//  Created by 박의서 on 2023/10/16.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DesignSystem
import BaseFeatureInterface
import RxSwift
import RxDataSources
import UtilityModule

final class SearchViewController: UIViewController, ContainerViewType {
    var contentView: UIView! = UIView()
    
    private var viewModel: SearchViewModel!
    
    let disposeBag = DisposeBag()
    private let input = SearchViewModel.Input()
    
    let beforeVc = BeforeSearchViewController()
    let afterVc = AfterSearchViewController()
    
    private let navigationBar = UIView()
    
    private lazy var backButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.addTarget(self, action: #selector(touchBackbtn), for: .touchUpInside)
    }
    
    private let searchBar = SearchBar()
    
    init(viewModel: SearchViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.add(asChildViewController: beforeVc)
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
//        bindViewModel()
    }
}

extension SearchViewController {
    private func updateAfterVC() {
        self.remove(asChildViewController: beforeVc)
        self.add(asChildViewController: afterVc)
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
    
    private func bindViewModel() {
        let output = self.viewModel.transform(input: input)
        bindTagDataSource(output: output)
        bindViewDidLoad(input: input)
    }
}

// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        updateAfterVC() // 수정 필요 ~
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Objc 함수
extension SearchViewController {
    @objc
    private func touchBackbtn() {
        self.navigationController?.popViewController(animated: true)
    }
}
