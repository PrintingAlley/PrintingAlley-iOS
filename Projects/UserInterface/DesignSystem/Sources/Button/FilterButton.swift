//
//  FilterButton.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/17.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public enum FilterButtonType {
    case basic
    case filter
    case selected
    case selectedWithX
}

public struct Tag: Hashable {
    public let name: String
    public let id: Int
    
    public init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

public final class FilterButton: UIButton {
    
    public var type: FilterButtonType {
        didSet {
            configureUI(type)
        }
    }
    
    public var title: String {
        didSet {
            configureUI(type)
        }
    }
    
    let disposeBag = DisposeBag()
    
    public var id: Int!
    
    public var willChangeUI: Bool = false {
        didSet {
            self.isUserInteractionEnabled = willChangeUI
        }
    }
    
    public init(title: String,id: Int, type: FilterButtonType, willChangeUI: Bool) {
        self.type = type
        self.title = title
        self.id = id
        self.willChangeUI = willChangeUI
        super.init(frame: .zero)
        configureUI(type)
        addTargets()
        
        NotificationCenter.default.rx.notification(Notification.Name("refreshFilter"))
            .map{ _ in () }
            .subscribe(onNext: { [weak self] _ in
                
                guard let self else {return}
                configureUI(self.type)
                self.isSelected = false
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterButton {
    func configureUI(_ type: FilterButtonType) {
        let stringSize = (title as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.setFont(.body1)])
        
        self.setRound([.allCorners], radius: 16)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.setFont(.body1)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        
        switch type {
        case .basic:
            self.backgroundColor = .setColor(.sub(.white))
            self.layer.borderColor = UIColor.setColor(.grey(.grey300)).cgColor
            self.layer.borderWidth = 1.0
            self.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            
        case .filter:
            self.backgroundColor = .setColor(.sub(.black))
            self.setImage(DesignSystemAsset.Icon.filter.image, for: .normal)
            self.setTitleColor(.setColor(.sub(.white)), for: .normal)
            
        case .selected:
            self.backgroundColor = .setColor(.grey(.grey100))
            self.layer.borderColor = UIColor.setColor(.grey(.grey900)).cgColor
            self.layer.borderWidth = 1.0
            self.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            self.titleLabel?.font = UIFont.setFont(.subtitle2)
            
        case .selectedWithX:
            self.backgroundColor = .setColor(.sub(.white))
            self.layer.borderColor = UIColor.setColor(.grey(.grey300)).cgColor
            self.layer.borderWidth = 1.0
            self.setTitleColor(.setColor(.grey(.grey900)), for: .normal)
            self.setImage(DesignSystemAsset.Icon.smallclose.image, for: .normal)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        }
        
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = .forceRightToLeft

    }
    private func addTargets() {
        self.addTarget(self, action: #selector(touchUpFilterButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpFilterButton() {
      
        toggle()
        
    }
    
    public func preSelected() {
        self.isSelected = true
        configureUI(.selected)
    }
    
    private func toggle() {
        self.isSelected.toggle()
        if willChangeUI, isSelected {
            configureUI(.selected)
        } else {
            configureUI(type)
        }
        
        NotificationCenter.default.post(name: Notification.Name("filterToggle"), object: Tag(name: self.title, id: self.id))
    }
}
