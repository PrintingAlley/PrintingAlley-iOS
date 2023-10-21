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

public enum MyPageCategory: String {
    case pushAlarmSetting = "앱 푸시 알림 설정"
    case faq = "자주 묻는 질문"
    case request = "1:1 문의하기"
    case service = "서비스 이용약관"
}

final class MyPageContentViewModel : ViewModelType {
 
    let categories:[MyPageCategory] = [.pushAlarmSetting, .faq, .request, .service]
    
    let disposeBag = DisposeBag()
    
    var fetchUserInfoUseCase: any FetchUserInfoUseCase
   
    init(fetchUserInfoUseCase: FetchUserInfoUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }
    
    struct Input {
        let fetchUserInfo: PublishSubject<Void> = .init()
    }
    
    struct Output {
        let userData: PublishRelay<UserInfoEntity> = .init()
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
                        DEBUG_LOG(err.localizedDescription)
                        
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
        
        return output
    }
}
