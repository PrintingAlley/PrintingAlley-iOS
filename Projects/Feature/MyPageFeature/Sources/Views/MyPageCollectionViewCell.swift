//
//  MyPageCollectionViewCell.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/10/08.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem

public enum HeaderItemType: String {
    
    case notice = "알림"
    case bookMark = "북마크"
    case like = "좋아요"
}

protocol MyPageCollectionViewCellDelegate: AnyObject {
    func tapHeaderItem(type: HeaderItemType)
}

class MyPageCollectionViewCell: UICollectionViewCell {
    
    var type: HeaderItemType!
    
    lazy var button: UIButton = UIButton()
    lazy var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    lazy var label: AlleyLabel = AlleyLabel()
    public weak var delegate: MyPageCollectionViewCellDelegate?
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubviews(button, imageView, label)
        button.addTarget(self, action: #selector(tapButton), for: .touchDown)
 
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MyPageCollectionViewCell {
    
    func makeConstraints() {
        button.snp.makeConstraints{
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(14)
            $0.bottom.equalTo(label.snp.top).offset(2)
        }
        
        label.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.centerX.equalTo(imageView.snp.centerX)
        }
    }
    
    public func update(type: HeaderItemType) {
        
        self.type = type
        
        switch type {
            
        case .notice:
            imageView.image = UIImage(systemName: "bell")
            
        case .bookMark:
            imageView.image = UIImage(systemName: "bookmark")
            
        case .like:
            imageView.image = UIImage(systemName: "heart")
        }
        
        label.setTitle(title: type.rawValue, textColor: .grey(.grey1000), font: .body1)
        
    }
    
    @objc func tapButton() {
        delegate?.tapHeaderItem(type: type)
    }
}
