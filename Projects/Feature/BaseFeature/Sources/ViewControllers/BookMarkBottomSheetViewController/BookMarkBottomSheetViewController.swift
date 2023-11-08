//
//  ViewController.swift
//  DesignSystemDemo
//
//  Created by yongbeomkwak on 10/15/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import RxDataSources
import RxSwift
import UtilityModule
import BaseFeatureInterface

public protocol BookMarkBottomSheetViewControllerDelegate: AnyObject {
    func success(id: Int)
}

public class BookMarkBottomSheetViewController: UIViewController {
    
    var viewModel: BookMarkBottomSheetViewModel!
    var editModalFactory: any EditModalFactory
    
    let disposeBag = DisposeBag()
    
    lazy var naviTitleView: UIView = UIView()
    
    lazy var closeButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.close.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
        
    }
    
    lazy var titleLabel: AlleyLabel = AlleyLabel("저장 목록", textColor: .sub(.black), font: .header3, alignment: .center)
    
    
    lazy var headerView: NewListHeaderView = NewListHeaderView(frame: CGRect(x: .zero, y: .zero, width: .max, height: 80)).then {
        $0.delegate = self
    }
    
    lazy var tableView: UITableView = UITableView().then {
        $0.register(BookMarkListTableViewCell.self, forCellReuseIdentifier: BookMarkListTableViewCell.identifier)
        $0.tableHeaderView = headerView
        $0.separatorStyle = .none
        
    }
    
    public weak var delegate: BookMarkBottomSheetViewControllerDelegate?
    
    
    
    init(editModalFactory: EditModalFactory, viewModel: BookMarkBottomSheetViewModel!) {        

        self.editModalFactory = editModalFactory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    deinit {
        DEBUG_LOG("\(Self.self) Deinit ❌")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCommonUI()
        addSubviews()
        makeConstraints()
        bindViewModel()
        
    }
    


}

extension BookMarkBottomSheetViewController {
    
    func addSubviews() {
        self.view.addSubviews(naviTitleView, tableView)
        
        self.naviTitleView.addSubviews(closeButton, titleLabel)
    }
    
    func makeConstraints() {
        naviTitleView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(30)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(naviTitleView.snp.bottom).offset(18)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
        let input: BookMarkBottomSheetViewModel.Input = BookMarkBottomSheetViewModel.Input()
        let output = viewModel.transform(input: input)
        
        bindUiEvent(input: input)
        bindDataSource(output: output)
        bindFetchData(input: input)
        bindtapItem(input: input)
        bindResult(output: output)
        addResult(output: output)
        input.fetchData.onNext(())
        
    }
    

    
    func bindUiEvent(input: BookMarkBottomSheetViewModel.Input) {
        
        closeButton.rx
            .tap.subscribe(onNext: { [weak self] in
                
                guard let self else {return}
             
                UIView.animate(withDuration: 0.4) {
                    self.dismiss(animated: true)
                }
                
                
                
            })
            .disposed(by: disposeBag)
        
    }
}

extension BookMarkBottomSheetViewController: NewListHeaderViewDelegate {
    public func generateNewList() {
        
        let vc = editModalFactory.makeView(id: -1, title: "저장 목록 만들기", type: .newBookMark)
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: false)
        
    }
    
}
