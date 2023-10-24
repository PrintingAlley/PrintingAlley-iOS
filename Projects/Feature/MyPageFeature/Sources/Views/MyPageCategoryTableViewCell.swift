//
//  MyPageCategoryTableViewCell.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/10/08.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem

class MyPageCategoryTableViewCell: UITableViewCell {
    
    static let identifier: String = "MyPageCategoryTableViewCell"
    
    lazy var label: AlleyLabel = AlleyLabel()
    
    lazy var arrowImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit

        $0.image = DesignSystemAsset.Icon.rightArrow.image
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.contentView.addSubviews(label, arrowImageView)
        
            makeConstraints()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension MyPageCategoryTableViewCell {
    
    func makeConstraints() {
        
        label.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalTo(label.snp.centerY)
        }
    
    }
    
    public func update(category: MyPageCategory) {
        self.label.setTitle(title: category.rawValue, textColor: .grey(.grey1000), font: .body1)
    }
}
