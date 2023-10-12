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

public protocol MyPageFooterViewDelegate: AnyObject {
    
}

class MyPageFooterView: UIView {
    
    lazy var baseLine = UIView().then {
        $0.backgroundColor = .black
     }
    
    lazy var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var label: AlleyLabel = AlleyLabel()
    
    lazy var button: UIButton = UIButton().then{
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(colorFromRGB("F65749"), for: .normal)
        $0.titleLabel?.font = .setFont(.body1)
        
    }

    let disposeBag = DisposeBag()
    
    weak var deleagte: MyPageHeaderViewDelegate?
    
    init() {
        super.init(frame: .zero)
        self.addSubviews(baseLine,imageView,label,button)
        preProcessing()
        makeConstraints()
    }
        
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

}

extension MyPageFooterView {
    
    func preProcessing() {
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
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.top.equalTo(baseLine.snp.bottom).offset(24)
        }
        
        label.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.centerY.equalTo(imageView.snp.centerY)
        
        }
        
        button.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalTo(imageView.snp.centerY)
        }
        
    }
}


