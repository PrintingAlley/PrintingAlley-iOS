//
//  PrintShopPhotosCollectionViewCell.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import DesignSystem

class PrintShopPhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "PrintShopPhotosCollectionViewCell"
    
    lazy var imageView:UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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

extension PrintShopPhotosCollectionViewCell {
    
    func addSubviews() {
        self.contentView.addSubview(imageView)
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    public func update(id: String) {
        imageView.image = DesignSystemAsset.Logo.tmpPrintShop.image
    }
    
}
