//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import UserDomainInterface
import RxSwift
import RxRelay
import AuthDomainInterface
import BaseDomainInterface

public enum MyPageCategory: String {
    case pushAlarmSetting = "앱 푸시 알림 설정"
    case faq = "자주 묻는 질문"
    case request = "1:1 문의하기"
    case service = "서비스 이용약관"
    case copyright = "인쇄골목 저작권보호방침"
}

final class MyPageContentViewModel : ViewModelType {
 
    let categories:[MyPageCategory] = [.pushAlarmSetting,.request, .service,.copyright]
    
    let disposeBag = DisposeBag()
    
    var fetchUserInfoUseCase: any FetchUserInfoUseCase
    var logOutUseCase: any LogOutUseCase
    var withDrawUseCase: any WithDrawUseCase
   
    init(fetchUserInfoUseCase: FetchUserInfoUseCase,logOutUseCase : LogOutUseCase,withDrawUseCase : WithDrawUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.logOutUseCase = logOutUseCase
        self.withDrawUseCase = withDrawUseCase
    }
    
    struct Input {
        let fetchUserInfo: PublishSubject<Void> = .init()
        let tapLogOut: PublishSubject<Void> = .init()
        let tapWithDraw: PublishSubject<Void> = .init()
    }
    
    struct Output {
        let userData: PublishRelay<UserInfoEntity> = .init()
        let showToast: PublishSubject<BaseEntity> = .init()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        
        input
            .fetchUserInfo
            .flatMap({ [weak self]  _  -> Observable<UserInfoEntity> in
                
                guard let self else {return Observable.empty()}
                
                /// jwt 토큰을 통해 유저 데이터 가져오기
                return self.fetchUserInfoUseCase.execute()
                    .catch{ err in
                        
                        let alleryError = err.asAlleyError
                        
                        return Single<UserInfoEntity>.create { single in
                            single(.success(UserInfoEntity(id: 0, provider: "apple", name: "", profileImage: "", email: "", statusCode: 401, message: "")))
                            return Disposables.create()
                
                        }
                    }
                    .asObservable()
                
            })
            .subscribe(onNext: {
                /// 유저 데이터에 업데이트
                PreferenceManager.shared.setUserInfo(id: $0.id, name: $0.name, profileImage: $0.profileImage, email: $0.email, platform: .init(rawValue: $0.provider) ?? .apple)
            })
            .disposed(by: disposeBag)
        
        input.tapLogOut
            .flatMap({ [weak self] _  -> Observable<BaseEntity> in
                guard let self else {return Observable.empty()}
                
                /// jwt 토큰을 통해 유저 데이터 가져오기
                return self.logOutUseCase.execute()
                    .catch{ err in
                        
                       

                        let alleryError = err.asAlleyError
                        DEBUG_LOG(err.localizedDescription)
                        
                        return Single<BaseEntity>.create { single in
                            single(.success(BaseEntity(statusCode: 0, message: alleryError.errorDescription!)))
                            return Disposables.create()
                
                        }
                    }
                    .asObservable()
            })
            .do(onNext: {
                
                if $0.statusCode == 200 {
                    LOGOUT()
                }
                
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
        
        input.tapWithDraw
            .flatMap({ [weak self] _  -> Observable<BaseEntity> in
                guard let self else {return Observable.empty()}
                
                /// jwt 토큰을 통해 유저 데이터 가져오기
                return self.withDrawUseCase.execute()
                    .catch{ err in
                        
                        let alleryError = err.asAlleyError
                        DEBUG_LOG(err.localizedDescription)
                        
                        return Single<BaseEntity>.create { single in
                            single(.success(BaseEntity(statusCode: 0, message: alleryError.errorDescription!)))
                            return Disposables.create()
                
                        }
                    }
                    .asObservable()
            })
            .do(onNext: {
                
                if $0.statusCode == 200 {
                    LOGOUT()
                }
                
            })
            .bind(to: output.showToast)
            .disposed(by: disposeBag)
        
        return output
    }
}
