//
//  ProductDetailHeaderCollectionViewCell.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DesignSystem
import UtilityModule
import Kingfisher

class ProductDetailHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifer: String = "ProductDetailHeaderCollectionViewCell"
    
    lazy var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductDetailHeaderCollectionViewCell {
    public func update(image: String) {
        imageView.image = DesignSystemAsset.Logo.productDummy.image
    }
}
