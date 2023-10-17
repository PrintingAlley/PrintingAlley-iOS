//
//  BookMarkTableViewCell.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import UtilityModule



class BookMarkListTableViewCell: UITableViewCell {

    static let identifier: String = "BookMarkListTableViewCell"
    
    lazy var containerView: UIView = UIView().then {
        $0.isUserInteractionEnabled = true
    }
    lazy var titleLabel: AlleyLabel = AlleyLabel()
    lazy var subtitleLabel: AlleyLabel = AlleyLabel()
    
    lazy var rightArrowImageView: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.image = DesignSystemAsset.Icon.rightArrow.image
    }
    
    lazy var baseLine: UIView = UIView().then{
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubviews()
            makeConstraints()
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension BookMarkListTableViewCell {
    func addSubviews() {
        self.contentView.addSubviews(containerView,baseLine)
        self.containerView.addSubviews(titleLabel,subtitleLabel,rightArrowImageView)
    }
    
    func makeConstraints() {
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(26)
            $0.left.equalTo(button.snp.right)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(button.snp.right).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalTo(titleLabel.snp.left)
            $0.bottom.equalToSuperview()
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.right.equalToSuperview()

        }
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(26)
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(26)
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
        
        
    }
    
    public func update(model: TmpModel, isLast: Bool) {
        
        titleLabel.setTitle(title: model.name, textColor: .grey(.grey1000), font: .body1)
        subtitleLabel.setTitle(title: "장소 \(model.contents.count)개", textColor: .grey(.grey500), font: .caption1)
        
        baseLine.layer.opacity = isLast ? 0 : 1
    }
    

}
