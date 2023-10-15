//
//  CategoryCollectionViewCell.swift
//  HomeFeature
//
//  Created by 박의서 on 2023/10/14.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DesignSystem

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let image = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.bookMark.image
        $0.contentMode = .scaleAspectFit
    }
    
    private let label = AlleyLabel("엽서/카드", textColor: .grey(.grey800),font: .body2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionViewCell {
    private func addSubviews() {
        contentView.addSubviews(image, label)
    }
    
    private func makeConstraints() {
        image.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
