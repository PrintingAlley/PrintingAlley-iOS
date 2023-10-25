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
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubviews(label, baseLine)
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.left.right.equalToSuperview()
        }
        
        label.snp.makeConstraints {
                $0.left.equalToSuperview().inset(24)
                $0.top.equalTo(baseLine.snp.bottom).offset(16)
                $0.bottom.right.equalToSuperview()

        }
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func update(name: String) {
        self.label.setTitle(title: name, textColor: .sub(.black), font: .subtitle2)
    }
    
}


