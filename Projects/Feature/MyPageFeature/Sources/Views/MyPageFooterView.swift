//
//  MyPageHeaderView.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/10/08.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import DesignSystem
import RxSwift
import RxCocoa

public enum UserLogoutAction {
    case logout
    case withdraw
}

public protocol MyPageFooterViewDelegate: AnyObject {
    func action(type: UserLogoutAction)
}

class MyPageFooterView: UIView {
    
    lazy var baseLine = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
     }
    
    lazy var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var label: AlleyLabel = AlleyLabel()
    
    lazy var button: UIButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(colorFromRGB("F65749"), for: .normal)
        $0.titleLabel?.font = .setFont(.body1)

    }
    
    lazy var infoImageView: UIImageView = UIImageView().then {
        
        $0.contentMode = .scaleAspectFill
        $0.image = DesignSystemAsset.Icon.warning.image
    }
    
    lazy var withDrawButton: UIButton = UIButton().then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setTitleColor(DesignSystemAsset.Grey.grey500.color, for: .normal)
        $0.titleLabel?.font = .setFont(.body1)
            
    }

    let disposeBag = DisposeBag()
    
    public weak var deleagte: MyPageFooterViewDelegate?
    
    init() {
        super.init(frame: .zero)
        preProcessing()
        self.addSubviews(baseLine, imageView, label, button, infoImageView, withDrawButton)
        makeConstraints()
        
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    @objc func tapLogOut() {
        DEBUG_LOG("HELLO")
        deleagte?.action(type: .logout)
    }
    
    @objc func tapWithdraw() {
        DEBUG_LOG("HELLO2")
        deleagte?.action(type: .withdraw)
    }

}

extension MyPageFooterView {
    
    func preProcessing() {
        
        button.addTarget(self, action: #selector(tapLogOut), for: .touchUpInside)
        withDrawButton.addTarget(self, action: #selector(tapWithdraw), for: .touchUpInside)
        
        PreferenceManager
            .$user
            .withUnretained(self)
            .subscribe(onNext: { (owner, user) in
            
                guard let user = user else { return }
                
                switch user.platform {
                 
                case .kakao:
                    owner.imageView.image = DesignSystemAsset.Logo.kakaoTalk.image
                    owner.label.setTitle(title: "카카오 계정 회원", textColor: .grey(.grey1000), font: .body1)
                    
                case .naver:
                    owner.imageView.image = DesignSystemAsset.Logo.naver.image
                    owner.label.setTitle(title: "네이버 계정 회원", textColor: .grey(.grey1000), font: .body1)
                    
                case .google:
                    owner.imageView.image = DesignSystemAsset.Logo.google.image
                    owner.label.setTitle(title: "구글 계정 회원", textColor: .grey(.grey1000), font: .body1)
                    
                case .apple:
                    owner.imageView.image = DesignSystemAsset.Logo.apple.image
                    owner.label.setTitle(title: "애플 계정 회원", textColor: .grey(.grey1000), font: .body1)
                }
           
        })
        .disposed(by: disposeBag)
    
    }
    
    func makeConstraints() {
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(15)
            $0.left.equalToSuperview().inset(24)
            $0.top.equalTo(baseLine.snp.bottom).offset(32)
        }
        
        label.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.centerY.equalTo(imageView.snp.centerY)
        
        }
        
        button.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalTo(imageView.snp.centerY)
        }
        
        infoImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        withDrawButton.snp.makeConstraints {
            $0.left.equalTo(infoImageView.snp.right).offset(4)
            $0.centerY.equalTo(infoImageView.snp.centerY)
        }
        
    }
    
}
