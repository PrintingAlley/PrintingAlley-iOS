//
//  SecondFillterTableViewCell.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import BaseDomainInterface


class SecondFillterTableViewCell: UITableViewCell {

    public static let identifier = "SecondFillterTableViewCell"
    
    lazy var tableView: UITableView = UITableView().then{
        $0.register(ThirdFillterTableViewCell.self, forCellReuseIdentifier: ThirdFillterTableViewCell.identifier)
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.delegate = self
    }
    
    var model: ChildrenTagEntity = ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: [])
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public func update(model: ChildrenTagEntity) {
        self.model = model
        
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
        model.children.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdFillterTableViewCell.identifier, for: indexPath) as? ThirdFillterTableViewCell else {
            return UITableViewCell()
        }
        
        cell.update(model: model.children[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}
