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

class FilterSectionHeaderView: UITableViewHeaderFooterView {
    
    static let identifer = "FilterSectionHeaderView"
    
    lazy var label: AlleyLabel = AlleyLabel()
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        
        
        self.addSubviews(label, baseLine)
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.left.right.equalToSuperview()
        }
        
        label.snp.makeConstraints {
                $0.left.equalToSuperview().inset(24)
                $0.top.equalTo(baseLine.snp.bottom).offset(16)
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-16)

        }
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func update(name: String) {
        
        baseLine.isHidden = name == "인쇄 방식"
        
        self.label.setTitle(title: name, textColor: .sub(.black), font: .subtitle2)
    }
    
}


