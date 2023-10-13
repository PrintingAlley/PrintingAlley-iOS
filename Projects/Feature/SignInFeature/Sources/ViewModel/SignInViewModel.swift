//
//  SignInViewModel.swift
//  SignInFeature
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
import UtilityModule
import NaverThirdPartyLogin
import AuthenticationServices
import KakaoSDKUser
import KakaoSDKAuth
import AuthDomainInterface


final class SignInViewModel: NSObject, ViewModelType {

    let disposeBag = DisposeBag()
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let oauthToken: PublishRelay<(String,LoginType)> = PublishRelay()
    
    var fetchLoginUseCase: any FetchLoginUseCase
    
    
    init(fetchLoginUseCase: FetchLoginUseCase!) {
        self.fetchLoginUseCase = fetchLoginUseCase
    }
    
    struct Input {
        let tapLoginButton: PublishRelay<LoginType> = .init()
    }
    
    struct Output {
        let runGoogleLogin: PublishRelay<Void> = .init()
        let loginResult: PublishSubject<Void> = .init()
        
    }

    func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.tapLoginButton
            .withUnretained(self)
            .subscribe(onNext: { (owner, type) in
                
                switch type {
                    
                case .kakao:
                    
                    // 카카오톡 실행 가능 여부 확인
                    // 카카오톡 실행 가능 여부 확인
                    if  UserApi.isKakaoTalkLoginAvailable() {
                        owner.loginWithKakaoTalk()
                    } else {
                        owner.loginWithOutKakaoTalk()
                    }
                    
                case .naver:
                    owner.naverLogin()
                    
                case .google:
                    output.runGoogleLogin.accept(())
                    
                case .apple:
                    owner.appleLogin()
                    
                }
                
        })
        .disposed(by: disposeBag)
        
        oauthToken
            .flatMap{ [weak self] (accessToken,type) -> Observable <TokenEntity> in
                
                guard let self else {return Observable.empty()}
                
                return self.fetchLoginUseCase
                    .execute(accessToken: accessToken, provider: type.rawValue)
                    .asObservable()
            }
            .subscribe(onNext:{
                DEBUG_LOG("제발 받아와 !! \($0) ")
            })
            .disposed(by: disposeBag)
            
        return output
    }
}

extension SignInViewModel {
    
    func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk {[weak self] (oauthToken, error) in
            
            guard let self else {return}
            
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")

                guard let accessToken = oauthToken?.accessToken else {
                    return
                }
                
                // do something
                self.oauthToken.accept((accessToken,.kakao))

            }
        }
    }
    
    func loginWithOutKakaoTalk() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
            
            guard let self else {return}
            
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")

                // do something
                guard let accessToken = oauthToken?.accessToken else {
                    return
                }
                
                // do something
                self.oauthToken.accept((accessToken,.kakao))
            }
        }
    }
    
    func naverLogin() {
        self.naverLoginInstance?.delegate = self
        self.naverLoginInstance?.requestThirdPartyLogin()
    }
    
    func appleLogin() {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName]
        let auth = ASAuthorizationController(authorizationRequests: [request])
        auth.delegate = self
        auth.presentationContextProvider = self
        auth.performRequests()
    }
    
}

extension SignInViewModel: NaverThirdPartyLoginConnectionDelegate {
    
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        
        guard let accessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        if !accessToken { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        DEBUG_LOG("NAVER SUCESS \(accessToken)")
        oauthToken.accept((accessToken,.naver))
        
    }
    
    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        guard let accessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        if !accessToken { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        DEBUG_LOG("NAVER SUCESS2 \(accessToken) ")
        
        oauthToken.accept((accessToken,.naver))
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        DEBUG_LOG("NAVER LOG OUT")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        DEBUG_LOG("NAVER EEROR: \(error)")
    }
    
}

extension SignInViewModel:ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.last!
     }

    // 성공하여 로그인
     public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
         if let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let rawData =  credential.identityToken {
             let token = String(decoding: rawData, as: UTF8.self)
             oauthToken.accept((token,.apple))
         }
     }

     public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
         //isErrorString.accept(error.localizedDescription)
     }

}
