//
//  SignInViewController.swift
//  SignInFeature
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import KakaoSDKCommon

class SignInViewController: UIViewController {

    let versionLabel: UILabel = UILabel().then {
        $0.text = "버전정보 \(APP_VERSION())"
        $0.textAlignment = .center
    }
    
    let stackView: UIStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    let kakaoButton: LoginButtonView = LoginButtonView(type: .kakao)
    let naverButton: LoginButtonView = LoginButtonView(type: .naver)
    let appleButton: LoginButtonView = LoginButtonView(type: .apple)
    let googleButton: LoginButtonView = LoginButtonView(type: .google)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        kakaoButton.delegate = self
        naverButton.delegate = self
        appleButton.delegate = self
        googleButton.delegate = self
        addSubviews()
        makeConstraints()
        DEBUG_LOG("HELLO")
        
        // Do any additional setup after loading the view.
    }
    
}

extension SignInViewController {
    
    func addSubviews() {
        self.view.addSubview(versionLabel)
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(kakaoButton)
        self.stackView.addArrangedSubview(naverButton)
        self.stackView.addArrangedSubview(appleButton)
        self.stackView.addArrangedSubview(googleButton)
        
    }
    
    func makeConstraints() {
        
        versionLabel.snp.makeConstraints {
            
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(52)
            
        }
        
        kakaoButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.left.right.equalToSuperview()
        }
        
        naverButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.left.right.equalToSuperview()
        }
        
        appleButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.left.right.equalToSuperview()
        }
        
        googleButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.left.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(versionLabel.snp.top).offset(-55)
        }
    }
    
}

extension SignInViewController:LoginButtonViewDelegate {
    func action(type: LoginType) {
        DEBUG_LOG(type)
    }
    
}
