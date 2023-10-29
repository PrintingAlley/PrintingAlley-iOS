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
    lazy var selectedBar: UIView = UIView()
    
    
    override var isSelected: Bool {
        didSet {
            label.font = isSelected ? .setFont(.body1) : .setFont(.subtitle1)
            label.textColor = isSelected ? .black : .red
            
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
                            self.selectedBar.layoutIfNeeded()
                            self.selectedBar.alpha = self.isSelected ? 1 : 0

            }, completion: nil)
        }
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

extension PageTitleCollectionViewCell {
    func addSubviews() {
        self.contentView.addSubviews(label,selectedBar)
    }
    
    func makeConstraints() {
        label.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.horizontalEdges.equalToSuperview()
        }
        
        selectedBar.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.bottom.horizontalEdges.equalToSuperview()
            
        }
    }
    
    func update(title: String) {
        label.setTitle(title: title, textColor: .grey(.grey500), font: .body1,alignment: .center)
    }
}
