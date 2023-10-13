//
//  CategoryCollectionViewCell.swift
//  HomeFeatureInterface
//
//  Created by 박의서 on 2023/10/12.
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
    
    private let label = UILabel().then {
        $0.text = "Default Text"
        $0.font = .setFont(.caption2)
        $0.textColor = .cyan
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

extension CategoryCollectionViewCell {
    private func addSubviews() {
        contentView.addSubviews(image, label)
    }
    
    private func makeConstraints() {
        image.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(2)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func dataBind(text: String) {
        label.text = text
    }
}
