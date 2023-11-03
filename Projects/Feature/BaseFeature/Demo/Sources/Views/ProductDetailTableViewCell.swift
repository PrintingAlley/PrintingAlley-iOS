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
        $0.numberOfLines = 1
    }

    lazy var button: UIButton = UIButton().then {
        $0.setTitle("복사", for: .normal)
        $0.setTitleColor(DesignSystemAsset.MainBlue.blue500.color, for: .normal)
        $0.titleLabel?.font = .setFont(.body2)
        
        $0.setImage(DesignSystemAsset.Icon.copy.image, for: .normal)
        
        $0.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
        $0.semanticContentAttribute = .forceLeftToRight // 이미지 왼쪽에 배치
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4) //<- 중요
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension ProductDetailTableViewCell {
    func addSubviews() {
        self.contentView.addSubviews(titleLabel,button,baseLine)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(24)
            $0.width.lessThanOrEqualTo(APP_WIDTH() - (24+53+8+24)) // 왼쪽 24 , 복사버튼 width , offset + right(24)
        }
    
        button.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.width.equalTo(53)
            $0.height.equalTo(24)
            $0.left.equalTo(titleLabel.snp.right).offset(8)
          
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
    
    public func update(model: String,index: Int) {
        
        switch index {
        case 0:
            titleLabel.setMultipleAttributeText(text1: "제작 인쇄사    ", text2: model, color1: .black, color2: .black, font1: .subtitle3, font2: .body2)
            
        case 1:
            titleLabel.setMultipleAttributeText(text1: "제품 크기    ", text2: model, color1: .black, color2: .black, font1: .subtitle3, font2: .body2)
        case 2:
            titleLabel.setMultipleAttributeText(text1: "종이    ", text2: model, color1: .black, color2: .black, font1: .subtitle3, font2: .body2)
            
        case 3:
            titleLabel.setMultipleAttributeText(text1: "인쇄 방식   ", text2: model, color1: .black, color2: .black, font1: .subtitle3, font2: .body2)
        case 4:
            titleLabel.setMultipleAttributeText(text1: "후가공    ", text2: model, color1: .black, color2: .black, font1: .subtitle3, font2: .body2)
            
        default:
            return
        }
        

        button.isHidden = index != 0
        baseLine.isHidden = index == 4
        
    }
}
