//
//  ProductDetailTableViewCell.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import UtilityModule

class ProductDetailTableViewCell: UITableViewCell {

    
    static let identifer: String = "ProductDetailTableViewCell"
    
    lazy var titleLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    
    var model:String!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        makeConstraints()
        self.contentView.backgroundColor = .setColor(.sub(.white))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension ProductDetailTableViewCell {
    func addSubviews() {
        self.contentView.addSubviews(titleLabel)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.left.right.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.lessThanOrEqualTo(APP_WIDTH() - (24+24))
            $0.bottom.equalToSuperview()
        }
        
    }
    
    public func update(model: String,index: Int) {
        
        self.model = model
        switch index {
      
        case 0:
            titleLabel.setMultipleAttributeText(text1: "크기    ", text2: model, color1: DesignSystemAsset.Grey.grey300.color, color2: .black, font1: .subtitle3, font2: .body2)
        case 1:
            titleLabel.setMultipleAttributeText(text1: "종이    ", text2: model, color1: DesignSystemAsset.Grey.grey300.color, color2: .black, font1: .subtitle3, font2: .body2)
            
        case 2:
            titleLabel.setMultipleAttributeText(text1: "인쇄 방식   ", text2: model, color1: DesignSystemAsset.Grey.grey300.color, color2: .black, font1: .subtitle3, font2: .body2)
        case 3:
            titleLabel.setMultipleAttributeText(text1: "후가공    ", text2: model, color1:DesignSystemAsset.Grey.grey300.color, color2: .black, font1: .subtitle3, font2: .body2)
            
        default:
            return
        }
            
        titleLabel.setLineSpacing(lineSpacing: 6)

        
    }
    
}
