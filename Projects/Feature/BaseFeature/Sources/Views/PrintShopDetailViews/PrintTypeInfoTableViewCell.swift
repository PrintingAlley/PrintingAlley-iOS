//
//  PrintTypeInfoTableViewCell.swift
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

final class PrintTypeInfoTableViewCell: UITableViewCell {

    public static let identifier = "PrintTypeInfoTableViewCell"
    
    private let title = AlleyLabel("인쇄 방식", textColor: .grey(.grey1000), font: .subtitle3, alignment: .left).then {
        $0.sizeToFit()
    }
    public lazy var label = AlleyLabel("", textColor: .grey(.grey500), font: .body2).then {
        $0.sizeToFit() // \(viewModel.printShop.printType)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .setColor(.grey(.grey50))
        contentView.setRound(.allCorners, radius: RADIUS1())
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrintTypeInfoTableViewCell {
    private func addSubviews() {
        contentView.addSubviews(title, label)
    }
    
    private func makeConstraints() {
        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom)
            $0.leading.equalTo(title)
        }
    }
    
    public func update(model: String, index: Int) { // 모델을 어떻게 받아야하지??
        switch index {
        case 0:
            title.text = "인쇄 방식"
        case 1:
            title.text = "후가공"
        case 2:
            title.text = "후가공(제본)"
        default:
            return
        }
    }
}
