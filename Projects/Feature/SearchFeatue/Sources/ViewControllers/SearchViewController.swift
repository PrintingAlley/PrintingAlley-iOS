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
import BaseFeatureInterface

final class SearchViewController: UIViewController, ContainerViewType {
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large).then {
        $0.color = DesignSystemAsset.MainBlue.blue500.color
        $0.hidesWhenStopped = true
    }
    
    var contentView: UIView! = UIView()
    
    lazy var searchBar = SearchBar().then {
        $0.delegate = self
    }
    
    public lazy var printingTableView = UITableView().then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.register(PrintShopTableViewCell.self, forCellReuseIdentifier: PrintShopTableViewCell.identifier)
    }
    
    lazy var emptyHeaderView = SearchEmptyHeaderView()
    lazy var emptyErrorView = SearchEmptyButtonHeaderView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: APP_HEIGHT())).then {
        $0.setTitle(title: "알 수 없는 오류가 발생했습니다.", subtitle: "아래 버튼을 눌러 다시 시도해주세요.")
        $0.button.setTitle("다시 시도하기", for: .normal)
        $0.delegate = self
    }
    
    private var viewModel: SearchViewModel!
    
    let input = SearchViewModel.Input()
    lazy var output = viewModel.transform(input: input)

    let disposeBag = DisposeBag()
    
    var printShopDetailFactory: any PrintShopDetailFactory
    
    init(printShopDetailFactory: PrintShopDetailFactory, viewModel: SearchViewModel!) {
        DEBUG_LOG("\(Self.self) Init ✅ ")
        self.printShopDetailFactory = printShopDetailFactory
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
        bindUIEvent(input: input)
        bindDataSource(input: input, output: output)
        bindIndicator(output: output)
        bindItemSelected()
        bindTableView()
        bindToast(output: output)
        bindShowErrorView(output: output)
        input.pageID.accept(1)
    }
}

// MARK: - UI 관련 함수들
extension SearchViewController {
    private func addSubviews() {
        view.addSubviews(searchBar, printingTableView, indicator)
    }
    
    private func makeConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.height.equalTo(56)
        }
        
        printingTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

    }
    
    private func setKeyboardDown() {
        let keyboardDownGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(keyboardDownGesture)
        keyboardDownGesture.cancelsTouchesInView = false
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

extension SearchViewController: SearchBarDelegate, SearchEmptyButtonHeaderDelegate {
    func press() {
        input.textString.accept("")
        input.pageID.accept(1)
    }
    
    func resetPage() {
        input.pageID.accept(1)
    }
    
    func pressSearchEmptyButton() {
        input.pageID.accept(1)
        input.textString.accept("")
        searchBar.touchSearchIcon()
    }
}
