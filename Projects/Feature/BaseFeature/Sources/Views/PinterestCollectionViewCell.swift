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
    
    var imageView = UIImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PinterestCollectionViewCell {
    private func configureUI() {
        contentView.setRound([.allCorners], radius: 8)
    }
}
