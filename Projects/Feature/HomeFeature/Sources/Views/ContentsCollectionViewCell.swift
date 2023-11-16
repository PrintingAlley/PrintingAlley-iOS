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
import Kingfisher
import ContentDomainInterface
import UtilityModule

final class ContentsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ContentsCollectionViewCell"
    
    private let image = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.setRound(.allCorners, radius: RADIUS1())
    }
    
    private let label = AlleyLabel().then {
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 2
    }
    
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

extension ContentsCollectionViewCell {
    private func addSubviews() {
        contentView.addSubviews(image, label)
    }
    
    private func makeConstraints() {
        image.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(171)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    public func update(model: ContentEntity) {
        image.kf.setImage(with: URL(string: model.thumbnail))
        label.setTitle(title: model.title, textColor: .sub(.black), font: .caption1)
    }
}
