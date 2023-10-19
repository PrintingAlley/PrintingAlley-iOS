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
import UtilityModule

class BookMarkViewController: UIViewController {

    var viewModel: BookMarkViewModel!
    let input = BookMarkViewModel.Input()
    
    let disposeBag = DisposeBag()
    
    lazy var naviTitleView: UIView = UIView()
    lazy var backButton: UIButton = UIButton().then {
        
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    lazy var editOrDoneButton: UIButton = UIButton()
    
    lazy var deleteButton: UIButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitle("삭제", for: .disabled)
        
        $0.setTitleColor(DesignSystemAsset.Grey.grey300.color, for: .disabled)
        $0.setTitleColor(DesignSystemAsset.Sub.red.color, for: .normal)
        
//        $0.setImage(DesignSystemAsset.Icon.trash.image, for: .disabled)
//        $0.setImage(DesignSystemAsset.Icon.trashRed.image, for: .normal)
        
        $0.titleLabel?.font = .setFont(.body1)
        
//        $0.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
//        $0.semanticContentAttribute = .forceLeftToRight // 이미지 왼쪽에 배치
//        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0) //<- 중요
        
        
    }
    
    
    lazy var naviTitleLabel: AlleyLabel = AlleyLabel("저장목록", textColor: .sub(.black), font: .header3, alignment: .center)
    
    lazy var tableView :UITableView = UITableView().then {
        $0.register(BookMarkTableViewCell.self, forCellReuseIdentifier: BookMarkTableViewCell.identifier)
        $0.separatorStyle = .none
    }
    

    
    init(viewModel: BookMarkViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommonUI()
        
        addSubviews()
        makeConstraints()
        bindViewModel()
    }
    
}

extension BookMarkViewController {
    func addSubviews() {
        self.view.addSubviews(naviTitleView,tableView)
        naviTitleView.addSubviews(backButton, naviTitleLabel,deleteButton, editOrDoneButton)
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
        
        
        deleteButton.snp.makeConstraints {
            $0.width.height.equalTo(29)
            $0.centerY.equalToSuperview()
            $0.right.equalTo(editOrDoneButton.snp.left).offset(-10)
        }
        
        editOrDoneButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(29)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(naviTitleView.snp.bottom).offset(23)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
       
        let output = self.viewModel.transform(input: input)
        
        ///bind Input
        bindEditState(input: input)
        bindStateInputWithButton(input: input)
        bindViewDidLoad(input: input)
        
        ///bind Output
        bindDataSource(input:input, output:output)
        bindIndexOfSelectedItem(output: output)
        bindBackButton()
    }
    
  
    

}


extension BookMarkViewController: BookMarkTableViewCellDelegate {
    func tapChecked(index: Int?) {
        
        guard let index = index as? Int else {
            return
        }
        
        input.tapItem.onNext(index)
       
        
    }
    
}
