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
import UtilityModule
import RxSwift
import RxDataSources
import BaseFeatureInterface
import RxCocoa

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
        
        let input = SearchViewModel.Input()
        bindUIEvent(input: input)
        
        let output = self.viewModel.transform(input: input)
//        bindDataSource(output: output)
    }
    
    func bindUIEvent(input: SearchViewModel.Input) {
        searchBar.searchTextField.rx
            .edit.subscribe(onNext: { [weak self] in
            guard let self else { return }
                changeToAfterVC()
        })
            .disposed(by: disposeBag)
        
        searchBar.searchTextField.rx
            .endEdit.subscribe(onNext: { [weak self] in
                guard let self else { return }
                if searchBar.searchTextField.hasText {
                    // ??
                } else {
                    changeToBeforeVC()
                }
            })
    }
    
    func bindDataSource(output: SearchViewModel.Output) {
        output.dataSource
            .bind(to: afterVc.printingTableView.rx.items) { (tableView, index, model) -> UITableViewCell in
                
                let indexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PrintingTableViewCell.identifier, for: indexPath) as? PrintingTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.bindData(model: model)
                
                return cell
            }
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

// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
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

// TODO: 따로 뺴기
extension Reactive where Base: UITextField {
    
    public var edit: ControlEvent<Void> {
        controlEvent(.editingChanged)
    }
    
    public var endEdit: ControlEvent<Void> {
        controlEvent(.editingDidEndOnExit)
    }
}
