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

class SecondFillterTableViewCell: UITableViewCell {

    public static let identifier = "SecondFillterTableViewCell"
    
    lazy var subtitleLabel: AlleyLabel = AlleyLabel()
    
    lazy var tableView: UITableView = UITableView().then{
        $0.register(TailFillterTableViewCell.self, forCellReuseIdentifier: TailFillterTableViewCell.identifier)
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.delegate = self
    }
    
    var model: ChildrenTagEntity = ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: [])
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubviews(tableView,subtitleLabel)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
        }
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public func update(model: ChildrenTagEntity) {
        self.model = model
        
        print("꽃: \(model)")
        self.subtitleLabel.setTitle(title: model.name, textColor: .grey(.grey300), font: .subtitle3)
        
        
        tableView.reloadData()
    }

}



extension SecondFillterTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
}

extension SecondFillterTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TailFillterTableViewCell.identifier, for: indexPath) as? TailFillterTableViewCell else {
            return UITableViewCell()
        }
        
        cell.update(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
}
