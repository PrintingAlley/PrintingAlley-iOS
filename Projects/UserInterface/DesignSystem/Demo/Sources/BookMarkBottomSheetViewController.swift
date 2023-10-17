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


class BookMarkBottomSheetViewController: UIViewController {

    
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
        $0.tableHeaderView = headerView
        
    }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
        addSubviews()
        makeConstraints()

    }
    


}

extension BookMarkBottomSheetViewController {
    func addSubviews() {
        self.view.addSubviews(naviTitleView, baseLine, tableView)
        
        self.naviTitleView.addSubviews(closeButton,titleLabel)
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
}


extension BookMarkBottomSheetViewController: ListHeaderViewDelegate {
    func generateNewList() {
        print("Hello")
    }
    
    
}
