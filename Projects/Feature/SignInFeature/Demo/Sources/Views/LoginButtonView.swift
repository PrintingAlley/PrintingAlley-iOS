//
//  LoginButtonView.swift
//  SignInFeature
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import DesignSystem

public protocol LoginButtonViewDelegate: AnyObject {
    func action(type: LoginType)
}

class LoginButtonView: UIView {
    
    var type: LoginType!
    weak var delegate: LoginButtonViewDelegate?
    var button: UIButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    var label: AlleyLabel = AlleyLabel()
    
    init(type: LoginType) {
        super.init(frame: .zero)
        self.type = type
        self.preProcessing()
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    @objc func event() {
        self.delegate?.action(type: type)
    }
}

extension LoginButtonView {
    
    func addSubviews() {
        self.backgroundColor = type.color
        self.addSubview(button)
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
    func preProcessing() {

        self.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(event), for: .touchDown)

        imageView.image = type.image
        
        self.label.setTitle(title: "HELLO", textColor: type.textColor, font: .body1)
    }
    
    func makeConstraints() {
        
        button.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(17)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.left.equalToSuperview().inset(20)
            $0.centerY.equalTo(label.snp.centerY)
           
        }
        
    }
    
}
