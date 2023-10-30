//
//  PageTitleCollectionViewCell.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/29/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem

class PageTitleCollectionViewCell: UICollectionViewCell {
    
    static let identifer: String = "PageTitleCollectionViewCell"
    
    lazy var label: AlleyLabel = AlleyLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleCollectionViewCell {
    func addSubviews() {
        self.contentView.addSubviews(label)
    }
    
    func makeConstraints() {
        label.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.horizontalEdges.equalToSuperview()
        }
        
    }
    
    func update(title: String, isSelectedIndex: Bool) {
        
        
        isSelectedIndex ?  label.setTitle(title: title, textColor: .sub(.black), font: .body1,alignment: .center)  :   label.setTitle(title: title, textColor: .grey(.grey500), font: .body1,alignment: .center)
        
    }
    

}
