//
//  PrintShopInfoTableViewCell.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/13.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import UtilityModule
// TODO: - 폴더 이동하기
class PrintShopInfoTableViewCell: UITableViewCell {
    
    static let identifier = "PrintShopInfoTableViewCell"
    
    private let iconImage = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.bell.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let label = AlleyLabel("텍스트", textColor: .sub(.black), font: .body2)
    
    private let separateLine = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.8)
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

extension PrintShopInfoTableViewCell {
    private func addSubviews() {
        contentView.addSubviews(iconImage, label, separateLine)
    }
    
    private func makeConstraints() {
        iconImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalTo(iconImage)
            $0.leading.equalTo(iconImage.snp.trailing).offset(10)
            $0.width.lessThanOrEqualTo(263)
        }
        
        separateLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.height.equalTo(1)
        }
    }
}
