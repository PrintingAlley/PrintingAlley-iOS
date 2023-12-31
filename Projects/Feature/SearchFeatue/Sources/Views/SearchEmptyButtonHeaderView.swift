//
//  SearchEmptyButtonHeaderView.swift
//  SearchFeatue
//
//  Created by 박의서 on 11/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit
import Then

public protocol SearchEmptyButtonHeaderDelegate: AnyObject {
    func pressSearchEmptyButton()
}

final class SearchEmptyButtonHeaderView: UIView {
    
    public let identifier = "CategoryEmptyHeaderView"
    
    public weak var delegate: SearchEmptyButtonHeaderDelegate?

    lazy var titleLabel: AlleyLabel = AlleyLabel("설정한 필터에 맞는 검색 결과가 없어요.", textColor: .sub(.black), font: .subtitle2, alignment: .center)
    
    lazy var subtitleLabel: AlleyLabel = AlleyLabel("필터를 조정하거나 초기화 해보세요.", textColor: .grey(.grey300), font: .subtitle3, alignment: .center)
    
    lazy var button: UIButton = UIButton().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
        $0.setTitle("필터 초기화", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .setFont(.subtitle2)
        
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.setColor(.grey(.grey100)).cgColor
        $0.layer.borderWidth = 1
        
        $0.addTarget(self, action: #selector(press), for: .touchUpInside)
        $0.addTarget(self, action: #selector(touchDown), for: .touchDown) // 애니메이션 효과
        $0.addTarget(self, action: #selector(touchCancel), for: .touchUpOutside)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(titleLabel, subtitleLabel, button)
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(208)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(163)
            $0.height.equalTo(48)
            
            $0.centerX.equalToSuperview()
            
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(18)
        }
                 
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setTitle(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    @objc func press() {
        UIView.animate(withDuration: 0.2) {
            self.button.alpha = 1.0
        }
        delegate?.pressSearchEmptyButton()
    }
    
    @objc func touchDown() {
        UIView.animate(withDuration: 0.2) {
            self.button.alpha = 0.4
        }
    }
    
    @objc func touchCancel() {
        UIView.animate(withDuration: 0.2) {
            self.button.alpha = 1.0
        }
    }
}
