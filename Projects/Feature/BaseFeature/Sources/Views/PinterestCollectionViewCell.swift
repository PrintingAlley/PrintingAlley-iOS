//
//  PinterestCollectionViewCell.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/10/31.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem

public final class PinterestCollectionViewCell: UICollectionViewCell {
    
    public static let identifer = "PinterestCollectionViewCell"
    
    public var imageView = UIImageView().then {
        $0.setRound([.allCorners], radius: 8)
        $0.image = DesignSystemAsset.Logo.tmpCard1.image
        $0.contentMode = .scaleAspectFit
    }
    
    public var title = AlleyLabel("Print Alley", textColor: .sub(.black), font: .caption1).then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PinterestCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubviews(imageView, title)
    }
    
    private func makeConstrains() {
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(171)
            $0.height.equalTo(self.imageView.image?.size.height ?? 0.0)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(imageView)
        }
    }
    
    public func update(model: Dummy) { // 변경 필요 (테스트용 함수임)
        self.imageView.image = model.image
        self.title.text = model.title
        
        imageView.snp.updateConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(171)
            $0.height.equalTo(model.image.size.height)
        }
        
        title.snp.updateConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(imageView)
        }
    }
}

public struct Dummy {
    public let image: UIImage
    public let title: String
    
    public init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
}
