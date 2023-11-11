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
import BaseFeature

final class SearchViewController: UIViewController, ContainerViewType {
    private var viewModel: SearchViewModel!
    
    let disposeBag = DisposeBag()
    let input = SearchViewModel.Input()
    
    var contentView: UIView! = UIView()
    
    let searchBar = SearchBar()
    
    public lazy var printingTableView = UITableView().then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        $0.register(PrintShopTableViewCell.self, forCellReuseIdentifier: PrintShopTableViewCell.identifier)
    }
    
    init(viewModel: SearchViewModel!) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        view.addSubviews(searchBar, printingTableView)
    }
    
    private func makeConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        printingTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
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


// MARK: - TableView 관련 함수들
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        106
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PrintShopTableViewCell.identifier, for: indexPath)
                as? PrintShopTableViewCell else { return UITableViewCell() }
        return cell
    }

}
