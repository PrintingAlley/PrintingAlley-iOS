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

    var completion: (([Int]) -> Void)?
    
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
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var findButton: UIButton = UIButton().then {
        $0.backgroundColor = DesignSystemAsset.MainBlue.blue500.color
        $0.setTitle("인쇄소 찾아보기", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Sub.white.color, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle1)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    lazy var resetButton: UIButton = UIButton().then {
        $0.setTitle("재설정", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Sub.black.color, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle2)
        $0.setImage(DesignSystemAsset.Icon.reFresh.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        
    }
    
    lazy var buttonContainerView: UIView = UIView()
    
    
    var dummy:[ChildrenTagEntity] = []
    
    
    init(completion: (([Int]) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.completion = completion
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.view.addSubviews(titleLabel, button, tableView, buttonContainerView,baseLine)
        self.buttonContainerView.addSubviews(resetButton,findButton)
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
            $0.bottom.equalTo(baseLine.snp.top)
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(buttonContainerView.snp.top).offset(-8)
        }
        
        buttonContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        resetButton.snp.makeConstraints {
            
            $0.left.equalToSuperview()
            $0.right.equalTo(findButton.snp.left).offset(-20)
            $0.centerY.equalTo(findButton.snp.centerY)
            $0.height.equalTo(24)
            $0.width.equalTo(68)
        }
        
        findButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(56)
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
            
            ]),
            
            ChildrenTagEntity(id: 0, name: "코딩123", image: "", parentID: 8, children: [
                
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
                ChildrenTagEntity(id: 12, name: "박 ", image: "", parentID: 12, children: [])
            
            ])
        
        ]),
        
        ChildrenTagEntity(id: 12, name: "후가공", image: "", parentID: 12, children: [
            
            
            ChildrenTagEntity(id: 0, name: "코딩", image: "", parentID: 8, children: [
                
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 14, name: "엠보코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 15, name: "CR코팅", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 12, name: "무광/ 유광 코팅2", image: "", parentID: 12, children: []),
                ChildrenTagEntity(id: 12, name: "박 ", image: "", parentID: 12, children: [])
            
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
        
        let h1: CGFloat = tempLabel.frame.height + 8
        
        let h2: CGFloat = subtitleLabel.frame.height
        
        let numberOfrow = numberOfItem % 3 == .zero ?  numberOfItem / 3 : numberOfItem / 3 + 1 // 필터 줄
        
        let offset1: CGFloat = 16.0
        let offset2: CGFloat = 8.0

        
        if dummy[section].children[row].children.isEmpty {
            
            // (row 수 * 셀크기 ) + (row-1 셀간격) + 하단에서 보정값
            return CGFloat(numberOfrow) * h1 + (CGFloat(numberOfrow-1)*offset2) + offset1
        }
        
        else  {
             
            // 셀 상단부터 제목까지 거리(offset1) + 제목 크기(h2) + (행 * 필터크기) + ( 행-1 * 간격) +  하단에서 보정값
            return offset2 + h2 + offset2 + (CGFloat(numberOfrow) * h1 ) + (CGFloat(numberOfrow-1) * offset2) + offset1
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
    

        //  2층 구조면 1개 , 아니면 children 개수 만큼 row
        return dummy[section].children.first?.children.isEmpty ?? true ? 1 : dummy[section].children.count
        
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
            cell.delegate = self 
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondFillterTableViewCell.identifier, for: indexPath) as? SecondFillterTableViewCell else {
                
                return UITableViewCell()
            }
            
            cell.update(model: dummy[section].children[row])
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
            
        }
        
        
    }
    
    
}


extension FillterViewController: TailFillterTableViewCellDelegate {
    func press(id: Int) {
        print("Tail: \(id)")
    }
    
    
}

extension FillterViewController: SecondFillterTableViewCellDelegate {
    func secondPress(id: Int ) {
        print("Second: \(id )")
    }
}
