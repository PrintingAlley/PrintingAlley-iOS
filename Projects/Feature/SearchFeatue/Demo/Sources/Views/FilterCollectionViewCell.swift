//
//  FilterCollectionViewCell.swift
//  SearchFeatueDemo
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//
import UIKit
import DesignSystem

public final class FilterCollectionviewCell: UICollectionViewCell {
    
    static let identifier = "FilterCollectionviewCell"
    
    public enum FilterButtonType {
        case basic
        case filter
        case arrowFilter
        case selected
        case selectedWithX
    }
    
    private let button = UIButton()
    
    public var type: FilterButtonType = .basic
    
    public var title: String = "리소인쇄"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addTarget()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterCollectionviewCell {
    private func addSubviews() {
        contentView.addSubviews(button)
    }
    
    private func makeConstraints() {
        button.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        let stringSize = (title as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.setFont(.body1)])
        
        button.setRound([.allCorners], radius: 16)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.setFont(.body1)
        
        switch self.type {
        case .basic:
            button.backgroundColor = .setColor(.sub(.white))
            button.layer.borderColor = UIColor.setColor(.grey(.grey300)).cgColor
            button.layer.borderWidth = 1.0
            button.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            
        case .filter:
            button.backgroundColor = .setColor(.mainBlue(.blue500))
            button.setImage(DesignSystemAsset.Icon.back.image, for: .normal) // 이미지 변경
            button.setTitleColor(.setColor(.sub(.white)), for: .normal)
            
        case .arrowFilter:
            button.backgroundColor = .setColor(.sub(.white))
            button.layer.borderColor = UIColor.setColor(.grey(.grey300)).cgColor
            button.layer.borderWidth = 1.0
            button.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            button.setImage(DesignSystemAsset.Icon.back.image, for: .normal) // 이미지 변경
            
        case .selected:
            button.backgroundColor = .setColor(.mainBlue(.blue50))
            button.layer.borderColor = UIColor.setColor(.mainBlue(.blue500)).cgColor
            button.layer.borderWidth = 1.0
            button.setTitleColor(.setColor(.mainBlue(.blue500)), for: .normal)
            button.titleLabel?.font = UIFont.setFont(.subtitle2)
            
        case .selectedWithX:
            button.backgroundColor = .setColor(.mainBlue(.blue50))
            button.layer.borderColor = UIColor.setColor(.mainBlue(.blue500)).cgColor
            button.layer.borderWidth = 1.0
            button.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            button.setImage(DesignSystemAsset.Icon.xmark.image, for: .normal)
        }
    
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    }
    
    func dummyDataBind(model: RecommendModel) {
        self.title = model.title
        configureUI()
    }
    
    private func addTarget() {
        button.addTarget(self, action: #selector(touchUpFilterButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpFilterButton() {
        print("탭 필터버튼")
    }
}
