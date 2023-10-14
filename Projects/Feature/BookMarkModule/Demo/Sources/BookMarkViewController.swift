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

class BookMarkViewController: UIViewController {

    lazy var naviTitleView: UIView = UIView()
    lazy var backButton: UIButton = UIButton().then {
        
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    lazy var naviTitleLabel: AlleyLabel = AlleyLabel("북마크", textColor: .sub(.black), font: .header3, alignment: .center)
    
    lazy var tableViewHeader: BookMarkHeaderView = BookMarkHeaderView(frame: CGRect(x: .zero, y: .zero, width: UIScreen.main.bounds.size.width, height: 64)).then {
        $0.delegate = self
    }
    
    lazy var tableView :UITableView = UITableView().then {
        $0.tableHeaderView = tableViewHeader
        $0.register(BookMarkTableViewCell.self, forCellReuseIdentifier: BookMarkTableViewCell.identifier)
    }
    
    var viewModel: BookMarkViewModel!

    
    let disposeBag = DisposeBag()
    
    init(viewModel: BookMarkViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        addSubviews()
        makeConstraints()
        bindViewModel()
    }
    
}

extension BookMarkViewController {
    func addSubviews() {
        self.view.addSubviews(naviTitleView,tableView)
        naviTitleView.addSubviews(backButton, naviTitleLabel)
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(naviTitleView.snp.bottom).offset(23)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func bindViewModel(){
        let input = BookMarkViewModel.Input()
        let output = self.viewModel.transform(input: input)
        
        bindDataSource(output:output)
        
    }
    
    func bindDataSource(output:BookMarkViewModel.Output) {
        
        output.dataSource
            .bind(to: tableView.rx.items) { (tableView, index, model) -> UITableViewCell in
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkTableViewCell.identifier, for: indexPath) as? BookMarkTableViewCell  else {
                    return UITableViewCell()
                }
                
                cell.deleagte = self
                
                cell.update(model: model)
                
                return cell
            }
        
            .disposed(by: disposeBag)
    }
}

extension BookMarkViewController: BookMarkHeaderViewDelegate {
    func action() {
        print("PREss")
    }
}

extension BookMarkViewController : BookMarkTableViewCellDelegate {
    func tapMore() {
        print("More")
    }
    
    
}
