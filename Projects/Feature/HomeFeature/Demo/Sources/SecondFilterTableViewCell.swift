//
//  SecondFillterTableViewCell.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import BaseDomainInterface
import DesignSystem



class SecondFilterTableViewCell: UITableViewCell {

    public static let identifier = "SecondFilterTableViewCell"
    
    lazy var subtitleLabel: AlleyLabel = AlleyLabel()
    
    lazy var tableView: UITableView = UITableView().then{
        $0.backgroundColor = .setColor(.sub(.white))
        $0.register(TailFilterTableViewCell.self, forCellReuseIdentifier: TailFilterTableViewCell.identifier)
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.delegate = self
    }
    
    var model: ChildrenTagEntity = ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: [])
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubviews(tableView,subtitleLabel)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(-4)
            $0.left.right.bottom.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
        }
        

        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public func update(model: ChildrenTagEntity) {
        self.model = model
        
        self.subtitleLabel.setTitle(title: model.name, textColor: .grey(.grey300), font: .subtitle3)
        
        
        tableView.reloadData()
    }

}



extension SecondFilterTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let titleLabel =  AlleyLabel("헤레헝로",font: .subtitle3).then {
            $0.sizeToFit()
        }
        
        let cell =  AlleyLabel("헤레헝로",font: .body1).then {
            $0.sizeToFit()
        }
        
        let h1 = cell.frame.height + 8
        let h2 = titleLabel.frame.height
      
        
        let offset1: CGFloat = 16.0
        let offset2: CGFloat = 8.0
        
        let numberOfrow = model.children.count % 3 == .zero ?  model.children.count / 3  : (model.children.count / 3)+1
        
            
        // (행 * 필터크기) + ( 행-1 * 간격) +
        return CGFloat(numberOfrow) * h1 + (CGFloat(numberOfrow-1) * offset2) + offset1
     }
}

extension SecondFilterTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TailFilterTableViewCell.identifier, for: indexPath) as? TailFilterTableViewCell else {
            return UITableViewCell()
        }
        
        cell.update(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
}

