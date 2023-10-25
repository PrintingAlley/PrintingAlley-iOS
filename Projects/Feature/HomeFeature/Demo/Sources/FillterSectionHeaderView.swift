//
//  FillterSectionHeaderView.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import DesignSystem

class FillterSectionHeaderView: UITableViewHeaderFooterView {
    
    static let identifer = "FillterSectionHeaderView"
    
    lazy var label: AlleyLabel = AlleyLabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubviews(label)
        
        label.snp.makeConstraints {
                $0.left.equalToSuperview().inset(24)
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
                $0.right.equalToSuperview()

        }
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func update(name: String) {
        self.label.setTitle(title: name, textColor: .sub(.black), font: .subtitle2)
    }
    
}


