//
//  TopCellSectionFooterView.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem

class TopCellSectionFooterView: UITableViewHeaderFooterView {

    static let identifer: String = "TopCellSectionFooterView"
    
    lazy var label: AlleyLabel = AlleyLabel("100부 이하는 소량인쇄입니다.", textColor: .grey(.grey500), font: .caption1)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubviews(label)
        
        
        label.snp.makeConstraints {
                $0.left.equalToSuperview().inset(24)
                $0.top.equalToSuperview().offset(8)
                $0.right.equalToSuperview()
                $0.bottom.equalToSuperview().inset(16)
        }
    
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
