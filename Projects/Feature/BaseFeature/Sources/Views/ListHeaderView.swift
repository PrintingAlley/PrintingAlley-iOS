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

public protocol ListHeaderViewDelegate: AnyObject {
    func generateNewList()
}

public class ListHeaderView: UIView {
    
    lazy var button: UIButton = UIButton().then {
        $0.addTarget(self, action: #selector(generateNewList), for: .touchUpInside)
    }
    
    lazy var imageView: UIImageView = UIImageView().then{
        $0.image = DesignSystemAsset.Icon.add.image //TODO: 나중에 변경 
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var label: AlleyLabel = AlleyLabel("새로운 목록 만들기", textColor: .grey(.grey1000) ,font: .body1 ,alignment: .left)
    
    weak var delegate: ListHeaderViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(button, imageView, label)
        makeConstraints()
    }
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

}

extension ListHeaderView {
 
    func makeConstraints() {
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.left.top.bottom.equalToSuperview().inset(24)
        }
        
        label.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.centerY.equalTo(imageView)
        }
        
    }
    
    @objc func generateNewList() {
        delegate?.generateNewList()
    }
    
}
