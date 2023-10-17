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

public class BookMarkBottomSheetViewController: UIViewController {
    
    var viewModel: BookMarkBottomSheetViewModel!
    
    let disposeBag = DisposeBag()
    
    lazy var naviTitleView: UIView = UIView()
    
    lazy var closeButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.xmark.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
        
    }
    
    lazy var titleLabel: AlleyLabel = AlleyLabel("저장 목록",textColor: .sub(.black), font: .header3, alignment: .center )
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var headerView: ListHeaderView = ListHeaderView(frame: CGRect(x: .zero, y: .zero, width: .max, height: 80)).then {
        $0.delegate = self
    }
    
    lazy var tableView: UITableView = UITableView().then {
        $0.register(BookMarkListTableViewCell.self, forCellReuseIdentifier: BookMarkListTableViewCell.identifier)
        $0.tableHeaderView = headerView
        $0.separatorStyle = .none
        
    }
    
    
    
    init(viewModel: BookMarkBottomSheetViewModel!) {
        super.init(nibName: nil, bundle: nil)

        
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        addSubviews()
        makeConstraints()
       bindViewModel()
        
    }
    


}

extension BookMarkBottomSheetViewController {
    func addSubviews() {
        self.view.addSubviews(naviTitleView, baseLine, tableView)
        
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
        
        baseLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(naviTitleView.snp.bottom).offset(18)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(baseLine.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
        let input: BookMarkBottomSheetViewModel.Input = BookMarkBottomSheetViewModel.Input()
        
        let output = viewModel.transform(input: input)
        bindDataSource(output: output)
        
    }
    
    func bindDataSource(output: BookMarkBottomSheetViewModel.Output) {
        
        output.dataSource
            .bind(to: tableView.rx.items) { (tableView, index, model) -> UITableViewCell  in
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkListTableViewCell.identifier, for: indexPath) as? BookMarkListTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.update(model: model)
                cell.selectionStyle = .none
                
                return cell
                
            }
            .disposed(by: disposeBag)
        
    }
}

extension BookMarkBottomSheetViewController: ListHeaderViewDelegate {
    public func generateNewList() {
        print("Hello")
    }
    
    
}
