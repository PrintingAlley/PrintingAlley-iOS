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

final class SearchViewController: UIViewController, ContainerViewType {
    var contentView: UIView! = UIView()
    
    private var viewModel: SearchViewModel!
    
    let disposeBag = DisposeBag()
    private let input = SearchViewModel.Input()
    
    let beforeVc = BeforeSearchViewController(viewModel: BeforeSearchViewModel())
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
        bindViewModel()
    }
}

// MARK: - 네트워크 관련 함수들
extension SearchViewController {
    private func bindViewModel() {
        bindUIEvent(input: input)
    }
    
    func bindUIEvent(input: SearchViewModel.Input) {
        let editingDidEnd = searchBar.searchTextField.rx.controlEvent(.editingDidEnd)
        let editingChanged = searchBar.searchTextField.rx.controlEvent(.editingChanged)
        
        searchBar.searchTextField.rx.text.orEmpty
            .skip(1)
            .distinctUntilChanged()
            .bind(to: self.input.textString)
            .disposed(by: disposeBag)
        
        editingChanged
            .subscribe(onNext: { [weak self] _ in
                guard let searchText = self?.searchBar.searchTextField.text else { return }
                guard let self = self else { return }
                
                if searchText.isEmpty {
                    self.changeToBeforeVC()
                } else {
                    print("\(searchText)")
                }
            })
            .disposed(by: disposeBag)
        
        editingDidEnd
            .map { [weak self] in self?.searchBar.searchTextField.text ?? "" } // 텍스트 필드의 현재 텍스트 가져오기
            .subscribe(onNext: { [weak self] searchText in
                guard let self = self else { return }
                
                if searchText.isEmpty {
                    print("비었다~")
                    self.changeToBeforeVC()
                } else {
                    self.changeToAfterVC()
                    print("안 비었다: \(searchText)")
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UI 관련 함수들
extension SearchViewController {
    private func changeToAfterVC() {
        UIView.animate(withDuration: 0.4) {
            self.remove(asChildViewController: self.beforeVc)
            self.add(asChildViewController: self.afterVc)
        }
    }
    
    private func changeToBeforeVC() {
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
