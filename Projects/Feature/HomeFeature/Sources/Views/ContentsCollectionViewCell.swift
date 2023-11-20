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
    
    private let label = AlleyLabel(textColor: .sub(.black), font: .body2).then {
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
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(171)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    public func update(model: ContentEntity) {
        image.kf.setImage(with: URL(string: model.thumbnail))
        
        let startIndex = model.title.startIndex
        let endIndex = model.title.endIndex
        if model.title.count < 16 { // 행간 맞추기
            label.text = model.title
        } else {
            
            let newLineIndex = model.title.index(startIndex, offsetBy: 16)
            
            let firstLabel = model.title.substring(with: startIndex..<newLineIndex)
            
            let secondLabel = model.title.substring(with: newLineIndex..<endIndex)
            label.text = firstLabel+"\n"+secondLabel
            label.setLineSpacing(lineSpacing: 5)
        }
    }
}
