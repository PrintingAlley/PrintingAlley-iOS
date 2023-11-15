//
//  CategoryEmptyHeaderView.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit
import Then

public protocol CategoryEmptyHeaderViewDelegate: AnyObject {
    func press()
}


class CategoryEmptyHeaderView: UIView {

    lazy var titleLabel: AlleyLabel = AlleyLabel("설정한 필터에 맞는 검색 결과가 없어요.",textColor: .sub(.black),font: .subtitle2,alignment: .center)
    
    lazy var subtitleLabel: AlleyLabel = AlleyLabel("필터를 조정하거나 초기화 해보세요.",textColor: .grey(.grey300),font: .subtitle3,alignment: .center)
    
    lazy var button: UIButton = UIButton().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
        $0.setTitle("필터 초기화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle2)
        
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.setColor(.grey(.grey100)).cgColor
        $0.layer.borderWidth = 1
        
        $0.addTarget(self, action: #selector(press), for: .touchUpInside)
        
        
    }
    
    public weak var delegate:CategoryEmptyHeaderViewDelegate?
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        
          self.addSubviews(titleLabel,subtitleLabel,button)
        
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(163)
            $0.height.equalTo(48)
            
            $0.centerX.equalToSuperview()
            
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
        }
        
              
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    @objc func press() {
        delegate?.press()
    }

}
