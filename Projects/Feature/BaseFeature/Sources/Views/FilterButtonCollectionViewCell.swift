//
//  RecommendCollectionViewCell.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import BaseDomainInterface

public final class FilterButtonCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "RecommendCollectionViewCell"
    
    private var filterButton = FilterButton(title: "기본버튼", id: 0, type: .basic, willChangeUI: true)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterButtonCollectionViewCell {
    private func addSubviews() {
        contentView.addSubviews(filterButton)
    }
    
    private func makeConstraints() {
        filterButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func update(model: ChildrenTagEntity, type: FilterButtonType, willChangeUI: Bool, preSelected: Bool =  false) {

        filterButton.title = model.name
        filterButton.id = model.id
        filterButton.type = type
        filterButton.willChangeUI = willChangeUI
        
        if preSelected {
            filterButton.preSelected()
        }
    }
}
