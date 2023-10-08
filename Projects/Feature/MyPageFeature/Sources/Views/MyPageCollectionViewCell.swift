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
    case bookMark = "북마크"
    case like = "좋아요"
}


class MyPageCollectionViewCell: UICollectionViewCell {
    
    static let identifer: String = "MyPageCollectionViewCell"
    
    var type: HeaderItemType!
    
    lazy var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    lazy var label: AlleyLabel = AlleyLabel()
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
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
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(14)
            $0.bottom.equalTo(label.snp.top).offset(-8)
        }
        
        label.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(imageView.snp.centerX)
        }
    }
    
    public func update(type: HeaderItemType) {
        
        self.type = type
        
        switch type {
            
        case .notice:
            imageView.image = UIImage(systemName: "bell")
            
        case .bookMark:
            imageView.image = UIImage(systemName: "bookmark")
            
        case .like:
            imageView.image = UIImage(systemName: "heart")
        }
        
        label.setTitle(title: type.rawValue, textColor: .grey(.grey1000), font: .body1)
        
    }
    
}
