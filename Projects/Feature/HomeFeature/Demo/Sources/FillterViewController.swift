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
        $0.register(TailFillterTableViewCell.self, forCellReuseIdentifier: TailFillterTableViewCell.identifier)
        $0.register(SecondFillterTableViewCell.self, forCellReuseIdentifier: SecondFillterTableViewCell.identifier)
        $0.register(FillterSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: FillterSectionHeaderView.identifer)
        $0.register(TopCellSectionFooterView.self, forHeaderFooterViewReuseIdentifier: TopCellSectionFooterView.identifer)
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
            ChildrenTagEntity(id: 13, name: "대량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 13, name: "대량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 13, name: "대량인쇄", image: "", parentID: 12, children: []),
            ChildrenTagEntity(id: 13, name: "대량인쇄", image: "", parentID: 12, children: []),
        ]),
        ChildrenTagEntity(id: 12, name: "후가공", image: "", parentID: 12, children: [
            
            
            ChildrenTagEntity(id: 0, name: "코딩", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 14, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 15, name: "CR코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅2", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅3", image: "", parentID: 12, children: [])
            
            ])
        
        ]),
        ChildrenTagEntity(id: 12, name: "후가공", image: "", parentID: 12, children: [
            
            
            ChildrenTagEntity(id: 0, name: "코딩", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 14, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 15, name: "CR코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅2", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅3", image: "", parentID: 12, children: [])
            
            ])
        
        ])
    
    ]
    }
    
}


extension FillterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let numberOfItem = dummy[section].children[row].children.isEmpty ? dummy[section].children.count : dummy[section].children[row].children.count
        
        
        let tempLabel = AlleyLabel("않입값히", font: .body1).then {
            $0.sizeToFit()
        }
        
        let subtitleLabel =  AlleyLabel("소제목 소제목",font: .subtitle3).then{
            $0.sizeToFit()
        }
        
        let height1: CGFloat = tempLabel.frame.height + 8
        
        let height2: CGFloat = subtitleLabel.frame.height
        
        let numberOfrow = numberOfItem % 3 == .zero ?  numberOfItem / 3 : numberOfItem / 3 + 1
        
        let offset1: CGFloat = 16.0
        let offset2: CGFloat = 8.0
        let offset3: CGFloat = 16.0
        
        if dummy[section].children[row].children.isEmpty {
            
            print("Type 1: \(CGFloat(numberOfrow) * height1 + CGFloat(8 * numberOfrow)-1)")
            
            print("Type 2: \(numberOfItem)")
            return CGFloat(numberOfrow) * height1 + CGFloat(8 * numberOfrow)-1 + 16
        }
        
        else  {
            print("Type 3: \(offset1 + height2 + offset2 + (CGFloat(numberOfrow) * height1 ) + (CGFloat(numberOfrow-1) * offset2) + offset3)")
            
            print("Type 4: \(numberOfItem)")
            
            return offset1 + height2 + offset2 + (CGFloat(numberOfrow) * height1 ) + (CGFloat(numberOfrow-1) * offset2) + offset3 + 16
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section != .zero ? UITableView.automaticDimension : .zero
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == .zero ? UITableView.automaticDimension : .zero
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
        
        if section == .zero {
            return nil
        }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FillterSectionHeaderView.identifer) as? FillterSectionHeaderView else {
            return UIView()
        }
        

        
        header.update(name: dummy[section].name)
        return header
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section != .zero {
            return nil
        }
        
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: TopCellSectionFooterView.identifer) as? TopCellSectionFooterView else {
            return UIView()
        }
        
        
        
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
             
        
        if dummy[section].children[row].children.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TailFillterTableViewCell.identifier, for: indexPath) as? TailFillterTableViewCell else {
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
