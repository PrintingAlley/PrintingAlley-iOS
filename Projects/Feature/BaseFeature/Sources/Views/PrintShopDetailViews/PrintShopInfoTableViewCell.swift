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
import BaseDomainInterface

final class PrintShopInfoTableViewCell: UITableViewCell {
    
    static let identifier = "PrintShopInfoTableViewCell"
    
    private let iconImage = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.bell.image
        $0.contentMode = .scaleToFill
    }
    
    private let label = AlleyLabel("텍스트", textColor: .sub(.black), font: .body2)
    
    private lazy var copyButton = CopyButton().then {
        $0.addTarget(self, action: #selector(copyLabel), for: .touchUpInside)
    }
    
    private var copyObject = "복사 대상"
    
    private let separateLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrintShopInfoTableViewCell {
    private func addSubviews() {
        contentView.addSubviews(iconImage, label, separateLine, copyButton)
    }
    
    private func makeConstraints() {
        iconImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalTo(iconImage.snp.trailing).offset(10)
            $0.width.lessThanOrEqualTo(263)
        }
        
        copyButton.snp.makeConstraints {
            $0.leading.equalTo(label.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(7)
            $0.width.equalTo(53)
            $0.height.equalTo(24)
        }
        
        separateLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.height.equalTo(0.8)
        }
    }
}

extension PrintShopInfoTableViewCell {
    public func update(model: PrintShopEntity, index: Int) {
        switch index {
        case 0:
            iconImage.image = DesignSystemAsset.Icon.locationGrey.image
            label.text = model.address
            copyObject = "주소"

        case 1:
            iconImage.image = DesignSystemAsset.Icon.callGrey.image
            label.text = model.phone
            copyObject = "연락처"

        case 2:
            iconImage.image = DesignSystemAsset.Icon.mailGrey.image
            label.text = model.email
            copyObject = "이메일 주소"

        default:
            return
        }
    }
    
    @objc
    func copyLabel() {
        COPY(text: self.label.text ?? "")
        contentView.showBottomToast(text: "\(copyObject)가 복사되었어요!")
    }
}
