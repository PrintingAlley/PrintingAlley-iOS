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

final class FilterButtonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendCollectionViewCell"
    
    private var filterButton = FilterButton(title: "기본버튼", type: .basic)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            $0.top.leading.equalToSuperview()
        }
    }
    
    func dummyDataBind(model: RecommendModel, type: FilterButtonType) {
        filterButton.title = model.title
        filterButton.type = type
    }
}
