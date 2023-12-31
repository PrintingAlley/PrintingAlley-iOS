//
//  PrintingTableViewCell.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import BaseDomainInterface
import UtilityModule
import Kingfisher

public final class PrintShopTableViewCell: UITableViewCell {
    public static let identifier = "PrintShopTableViewCell"
    
    private let image = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.setRound([.allCorners], radius: 9)
    }
    
    private let name = AlleyLabel("인쇄소 이름", textColor: .sub(.black), font: .subtitle1)
    
    private let introduction = AlleyLabel("인쇄소 소개", textColor: .sub(.black), font: .body2).then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private let address = AlleyLabel("주소", textColor: .grey(.grey500), font: .body2)
    
    private let separator = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .setColor(.sub(.white))
        addSubview()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI 관련 함수
extension PrintShopTableViewCell {
    private func addSubview() {
        contentView.addSubviews(separator, image, name, introduction, address)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.bottom.equalToSuperview()
        }
        
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(74)
        }

        name.snp.makeConstraints {
            $0.top.equalTo(image)
            $0.leading.equalTo(image.snp.trailing).offset(HORIZON_MARGIN1())
        }
        
        introduction.snp.makeConstraints {
            $0.leading.equalTo(name)
            $0.top.equalTo(name.snp.bottom).offset(2)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        address.snp.makeConstraints {
            $0.leading.equalTo(name)
            $0.top.equalTo(introduction.snp.bottom).offset(2)
        }
    }
}

// MARK: - 데이터 바인딩 함수
public extension PrintShopTableViewCell {
     func update(model: PrintShopEntity) {
         self.image.kf.setImage(with: URL(string: model.logoImage), placeholder: DesignSystemAsset.PlaceHolder.smallPH.image)
         self.name.text = model.name
         self.introduction.text = model.introduction
         self.address.text = model.address
     }
}
