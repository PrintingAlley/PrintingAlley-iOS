//
//  FillterViewController.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import BaseFeature
import DesignSystem
import SnapKit
import Then
import BaseDomainInterface
import UtilityModule

class FillterViewController: UIViewController {

    lazy var titleLabel: AlleyLabel = AlleyLabel("필터",textColor: .sub(.black),font: .subtitle1)
    lazy var button: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.downArrow.image, for: .normal)
    }
    lazy var tableView: UITableView = UITableView().then {
        $0.register(FirstFillterTableViewCell.self, forCellReuseIdentifier: FirstFillterTableViewCell.identifier)
        $0.register(SecondFillterTableViewCell.self, forCellReuseIdentifier: SecondFillterTableViewCell.identifier)
        $0.register(FillterSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: FillterSectionHeaderView.identifer)
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = . none
        $0.bounces = false
    }
    
    var dummy:[ChildrenTagEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()
        dummy = makeDummy()
        tableView.reloadData()
    }
    
}

extension FillterViewController {
    
    func addSubviews() {
        self.view.addSubviews(titleLabel,button,tableView)
        tableView.backgroundColor = .red
    }
    
    func makeConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.bottom.equalToSuperview()
        }
    }
    
    func makeDummy() -> [ChildrenTagEntity] {
        return [
        ChildrenTagEntity(id: 11, name: "수량", image: "", parentID: 2, children: [
            
            ChildrenTagEntity(id: 12, name: "소량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 13, name: "대량인쇄", image: "", parentID: 12, children: [])
        ]),
        ChildrenTagEntity(id: 12, name: "후가공", image: "", parentID: 12, children: [
            
            
            ChildrenTagEntity(id: 0, name: "코딩", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 14, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 15, name: "CR코팅", image: "", parentID: 12, children: [])
            
            ])
        
        ])
    
    ]
    }
    
}


extension FillterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300.0
    }
    

}

extension FillterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dummy.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        1
    }
    


    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FillterSectionHeaderView.identifer) as? FillterSectionHeaderView else {
            return UIView()
        }
        
        header.update(name: dummy[section].name)
        
        return header
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
       
        
        
        if dummy[section].children[row].children.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstFillterTableViewCell.identifier, for: indexPath) as? FirstFillterTableViewCell else {
                return UITableViewCell()
            }
            
            cell.update(model: dummy[section])
            cell.selectionStyle = .none
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondFillterTableViewCell.identifier, for: indexPath) as? SecondFillterTableViewCell else {
                
                return UITableViewCell()
            }
            
            cell.update(model: dummy[section].children[row])
            cell.selectionStyle = .none
            return cell
            
        }
        
        
    }
    
    
}
