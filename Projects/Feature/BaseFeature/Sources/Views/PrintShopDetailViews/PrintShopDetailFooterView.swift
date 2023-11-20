//
//  PrintShopDetailFooterView.swift
//  BaseFeature
//
//  Created by 박의서 on 11/19/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import UtilityModule
import BaseDomainInterface

final class PrintShopDetailFooterView: UIView {
    
    static let identifier = "PrintShopDetailFooterView"
    
    public var footerHeight: CGFloat = 0
    
    private let introductionIcon = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.dotTextBubble.image
        $0.contentMode = .scaleToFill
    }
    
    private let introductionLabel = AlleyLabel("-", textColor: .sub(.black), font: .body2).then {
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    private let separateLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100))
    }
    
    private let greyRoundView = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
        $0.setRound(.allCorners, radius: RADIUS1())
    }
    
    private let printTypeTitle = AlleyLabel("인쇄 방식", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left).then {
        $0.sizeToFit()
    }
    public lazy var printTypeLabel = AlleyLabel("-", textColor: .grey(.grey500), font: .body2).then {
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    
    private let afterProcessTitle = AlleyLabel("후가공", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left).then {
        $0.sizeToFit()
    }
    public lazy var afterProcessLabel = AlleyLabel("-", textColor: .grey(.grey500), font: .body2).then {
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    
    private let afterProcessBindingTitle = AlleyLabel("후가공(제본)", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left).then {
        $0.sizeToFit()
    }
    public lazy var afterProcessBindingLabel = AlleyLabel("-", textColor: .grey(.grey500), font: .body2).then {
        $0.sizeToFit()
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrintShopDetailFooterView {
    private func addSubviews() {
        self.addSubviews(introductionIcon, introductionLabel, separateLine, greyRoundView)
        greyRoundView.addSubviews(printTypeTitle, printTypeLabel, afterProcessTitle, afterProcessLabel, afterProcessBindingTitle, afterProcessBindingLabel)
    }
    
    private func makeConstraints() {
        introductionIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        introductionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(introductionIcon.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        separateLine.snp.makeConstraints {
            $0.bottom.equalTo(introductionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.height.equalTo(0.8)
        }
        
        greyRoundView.snp.makeConstraints {
            $0.top.equalTo(separateLine.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.height.equalTo(100)
        }
        
        printTypeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        printTypeLabel.snp.makeConstraints {
            $0.top.equalTo(printTypeTitle.snp.bottom)
            $0.leading.equalTo(printTypeTitle)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        afterProcessTitle.snp.makeConstraints {
            $0.top.equalTo(printTypeLabel.snp.bottom).offset(16)
            $0.leading.equalTo(printTypeLabel)
        }
        
        afterProcessLabel.snp.makeConstraints {
            $0.top.equalTo(afterProcessTitle.snp.bottom)
            $0.leading.equalTo(afterProcessTitle)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        afterProcessBindingTitle.snp.makeConstraints {
            $0.top.equalTo(afterProcessLabel.snp.bottom).offset(16)
            $0.leading.equalTo(afterProcessTitle)
        }
        
        afterProcessBindingLabel.snp.makeConstraints {
            $0.top.equalTo(afterProcessBindingTitle.snp.bottom)
            $0.leading.equalTo(afterProcessBindingTitle)
            $0.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
        }
    }
    
    public func update(model: PrintShopEntity) {
        let dividingBy = APP_WIDTH() - 16 * 4
        
        introductionLabel.text = model.introduction
        printTypeLabel.text = model.printType.isEmpty ? "-" : model.printType
        afterProcessLabel.text = model.afterProcess.isEmpty ? "-" : model.afterProcess
        afterProcessBindingLabel.text = model.afterProcessBinding.isEmpty ? "-" : model.afterProcessBinding
        
        separateLine.snp.updateConstraints {
            $0.bottom.equalTo(introductionLabel.snp.bottom).offset(10)
        }
        
        greyRoundView.snp.updateConstraints {
            $0.height.equalTo(printTypeTitle.frame.height * 3 + printTypeLabel.frame.height *  (ceil(printTypeLabel.frame.height / dividingBy) + ceil(afterProcessLabel.frame.height / dividingBy) + ceil(afterProcessBindingLabel.frame.height / dividingBy)) + 52)
        }
        
        footerHeight += greyRoundView.frame.size.height + introductionLabel.frame.height * (ceil(introductionLabel.frame.height / (APP_WIDTH() - HORIZON_MARGIN1() * 2 - introductionIcon.frame.width - 10))) + 9 + 16 + 8
    }
}
