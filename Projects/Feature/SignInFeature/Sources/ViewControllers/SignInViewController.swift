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
import GoogleSignIn
import RxSwift
import DesignSystem

public class SignInViewController: UIViewController {

    let disposeBag = DisposeBag()
    var viewModel: SignInViewModel!
    var input: SignInViewModel.Input!
    
    let versionLabel: AlleyLabel = AlleyLabel("버전정보 \(APP_VERSION())", textColor: .grey(.grey600), font: .caption1, alignment: .center)
    
    lazy var logoTitle: AlleyLabel = AlleyLabel("인쇄로 가는\n지름길,\n인쇄골목",textColor: .sub(.black),font: .header1,alignment: .center)
    
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
        configureCommonUI()
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
        
        self.view.addSubviews(versionLabel, stackView,logoTitle)
        self.stackView.addArrangedSubview(kakaoButton, naverButton, appleButton, googleButton)
        
    }
    
    func makeConstraints() {
        
        logoTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(97)
            $0.left.right.equalToSuperview()
            
        }
        
        versionLabel.snp.makeConstraints {
            
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(stackView.snp.bottom).offset(18)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(96)
            
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
            $0.horizontalEdges.equalToSuperview().inset(HORIZON_MARGIN1())
        }
    }
    
    func bindViewModel() {
        let output = viewModel.transform(input: input)
        bindshowToast(output: output)
        
        
        bindGoogleLogin(output: output)
    }
    
    func bindshowToast(output: SignInViewModel.Output) {
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner,content) in
                owner.view.showToast(text: content.message)
            })
            .disposed(by: disposeBag)
    }
    
     func bindGoogleLogin(output: SignInViewModel.Output) {
     
     output.runGoogleLogin.subscribe(onNext: { [weak self] in
     
     guard let self else {return}
     
     let id = GOOGLE_CLIENT_ID()  // 여기서는 반전시키지 말고 ID값 그대로 적용한다.
     let signInConfig = GIDConfiguration(clientID: id)
     
     GIDSignIn.sharedInstance.configuration = signInConfig
     
     GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
     guard let self else {return}
     guard error == nil else { return }
     guard let signInResult = signInResult else { return }
     
     let user = signInResult.user
     
     let emailAddress = user.profile?.email
     
     let fullName = user.profile?.name
     let givenName = user.profile?.givenName
     let familyName = user.profile?.familyName
     
     
         self.viewModel.oauthToken.accept((user.accessToken.tokenString, .google)) //TODO: 예외처리
     }
     
     })
     .disposed(by: disposeBag)
     
     
     }
     
}

extension SignInViewController: LoginButtonViewDelegate {
    public func action(type: LoginType) {
        input.tapLoginButton.accept(type)
    }
    
}
