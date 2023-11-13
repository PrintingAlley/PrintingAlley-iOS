//
//  MyPageCollectionViewCell.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/10/08.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem

public enum HeaderItemType: String {
    
    case notice = "알림"
    case bookMark = "저장목록"
    case review = "리뷰"
}


class MyPageCollectionViewCell: UICollectionViewCell {
    
    static let identifer: String = "MyPageCollectionViewCell"
    
    var type: HeaderItemType!
    
    lazy var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    lazy var label: AlleyLabel = AlleyLabel()
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.backgroundColor = .clear
        self.addSubviews(imageView, label)
        makeConstraints()
 
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MyPageCollectionViewCell {
    
    func makeConstraints() {
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.width.height.equalTo(28)
            $0.centerX.equalToSuperview()
            
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(-2)
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(imageView.snp.centerX)
        }
    }
    
    public func update(type: HeaderItemType) {
        
        self.type = type
        
        switch type {
            
        case .notice:
            imageView.image = DesignSystemAsset.Icon.bell.image
            
        case .bookMark:
            imageView.image = DesignSystemAsset.Icon.blackEmptyBookMark.image
            
        case .review:
            imageView.image = DesignSystemAsset.Icon.textBubble.image
        }
        
        label.setTitle(title: type.rawValue, textColor: .grey(.grey1000), font: .subtitle3)
        
    }
    
}
