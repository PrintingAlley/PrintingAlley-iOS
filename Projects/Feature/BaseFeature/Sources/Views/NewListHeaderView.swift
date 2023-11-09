//
//  ListHeaderView.swift
//  DesignSystemDemo
//
//  Created by yongbeomkwak on 10/17/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem

public protocol NewListHeaderViewDelegate: AnyObject {
    func generateNewList()
}

public class NewListHeaderView: UIView {
    
    lazy var button: UIButton = UIButton().then {
        $0.addTarget(self, action: #selector(generateNewList), for: .touchUpInside)
    }
    
    lazy var imageView: UIImageView = UIImageView().then{
        $0.image = DesignSystemAsset.Icon.roundAdd.image  
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var label: AlleyLabel = AlleyLabel("새로운 목록 만들기", textColor: .grey(.grey1000) ,font: .body1 ,alignment: .left)
    
    weak var delegate: NewListHeaderViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(button, imageView, label)
        makeConstraints()
        
    }
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

}

extension NewListHeaderView {
 
    func makeConstraints() {
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(33)
           
        }
        
        label.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(21)
            $0.centerY.equalTo(imageView).offset(-2)
        }
        
    }
    
    @objc func generateNewList() {
        delegate?.generateNewList()
    }
    
}
