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

public class SignInViewController: UIViewController {

    var viewModel: SignInViewModel!
    var input: SignInViewModel.Input!
    
    let versionLabel: UILabel = UILabel().then {
        $0.text = "버전정보 \(APP_VERSION())"
        $0.textAlignment = .center
    }
    
    let stackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    let kakaoButton: LoginButtonView = LoginButtonView(type: .kakao)
    let naverButton: LoginButtonView = LoginButtonView(type: .naver)
    let appleButton: LoginButtonView = LoginButtonView(type: .apple)
    let googleButton: LoginButtonView = LoginButtonView(type: .google)

    init(viewModel: SignInViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.input = SignInViewModel.Input()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        kakaoButton.delegate = self
        naverButton.delegate = self
        appleButton.delegate = self
        googleButton.delegate = self
        addSubviews()
        makeConstraints()
        bindViewModel()
        
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
    
    func bindViewModel() {
        let output = viewModel.transform(input: input)
    }
    
}

extension SignInViewController: LoginButtonViewDelegate {
    public func action(type: LoginType) {
        input.tapLoginButton.accept(type)
    }
    
}
