//
//  BookMarkTableViewCell.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import BookMarkDomainInterface
import Kingfisher



class BookMarkListTableViewCell: UITableViewCell {

    static let identifier: String = "BookMarkListTableViewCell"
    
    lazy var frontImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = DesignSystemAsset.Icon.blackBookMark.image
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    lazy var titleLabel: AlleyLabel = AlleyLabel()
    lazy var subtitleLabel: AlleyLabel = AlleyLabel()
    
    lazy var rightArrowImageView: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
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
        self.addSubviews(titleLabel,subtitleLabel,rightArrowImageView,frontImageView,baseLine)
    }
    
    func makeConstraints() {
        
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalToSuperview()
        }
        
        frontImageView.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.left.equalTo(frontImageView.snp.right).offset(12)
            $0.right.equalToSuperview().inset(52)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.left.right.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(13)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(frontImageView.snp.centerY)
            $0.right.equalToSuperview().inset(24)

        }
        

        
        
    }
    
    public func update(model: MyBookMarkEntity) {
        
        titleLabel.setTitle(title: model.name, textColor: .grey(.grey1000), font: .body1)
        subtitleLabel.setTitle(title: "장소 \(model.count)개", textColor: .grey(.grey500), font: .caption1)
        frontImageView.kf.setImage(with: URL(string: model.recentImage))
            
    }
    

}

