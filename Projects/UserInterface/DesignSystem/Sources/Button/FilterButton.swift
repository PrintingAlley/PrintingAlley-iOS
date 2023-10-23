//
//  FilterButton.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/17.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public enum FilterButtonType {
    case basic
    case filter
    case arrowFilter
    case selected
    case selectedWithX
}

public final class FilterButton: UIButton {
    
    public var type: FilterButtonType {
        didSet {
            configureUI()
        }
    }
    
    public var title: String {
        didSet {
            configureUI()
        }
    }
    
    public init(title: String, type: FilterButtonType) {
        self.type = type
        self.title = title
        super.init(frame: .zero)
        configureUI()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterButton {
    func configureUI() {
        let stringSize = (title as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.setFont(.body1)])
        
        self.setRound([.allCorners], radius: 16)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.setFont(.body1)
        
        switch self.type {
        case .basic:
            self.backgroundColor = .setColor(.sub(.white))
            self.layer.borderColor = UIColor.setColor(.grey(.grey300)).cgColor
            self.layer.borderWidth = 1.0
            self.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            
        case .filter:
            self.backgroundColor = .setColor(.mainBlue(.blue500))
            self.setImage(DesignSystemAsset.Icon.back.image, for: .normal) // 이미지 변경
            self.setTitleColor(.setColor(.sub(.white)), for: .normal)
            
        case .arrowFilter:
            self.backgroundColor = .setColor(.sub(.white))
            self.layer.borderColor = UIColor.setColor(.grey(.grey300)).cgColor
            self.layer.borderWidth = 1.0
            self.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            self.setImage(DesignSystemAsset.Icon.back.image, for: .normal) // 이미지 변경
            
        case .selected:
            self.backgroundColor = .setColor(.mainBlue(.blue50))
            self.layer.borderColor = UIColor.setColor(.mainBlue(.blue500)).cgColor
            self.layer.borderWidth = 1.0
            self.setTitleColor(.setColor(.mainBlue(.blue500)), for: .normal)
            self.titleLabel?.font = UIFont.setFont(.subtitle2)
            
        case .selectedWithX:
            self.backgroundColor = .setColor(.mainBlue(.blue50))
            self.layer.borderColor = UIColor.setColor(.mainBlue(.blue500)).cgColor
            self.layer.borderWidth = 1.0
            self.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            self.setImage(DesignSystemAsset.Icon.xmark.image, for: .normal)
        }
        
        self.semanticContentAttribute = .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    }
    private func addTargets() {
        self.addTarget(self, action: #selector(touchUpFilterButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpFilterButton() {
        print("탭 필터버튼")
    }
}