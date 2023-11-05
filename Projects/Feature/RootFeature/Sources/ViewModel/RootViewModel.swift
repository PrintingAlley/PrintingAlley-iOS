//
//  RootViewModel.swift
//  RootFeature
//
//  Created by yongbeomkwak on 10/22/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import RxSwift
import AuthDomainInterface

final class RootViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    var logOutUseCase: any LogOutUseCase
    var verifyUserUseCase: any VerifyUserUseCase
    var versionCheckUseCase: any VersionCheckUseCase
    
    init(logOutUseCase: LogOutUseCase, verifyUserUseCase: VerifyUserUseCase, versionCheckUseCase:VersionCheckUseCase) {
        self.logOutUseCase = logOutUseCase
        self.verifyUserUseCase = verifyUserUseCase
        self.versionCheckUseCase = versionCheckUseCase
    }
    
    public struct Input {
        let startLottie: PublishSubject<Void> = .init()
        let fetchVersionCheck: PublishSubject<Void> = .init()
        let fetchUserCheck: PublishSubject<Void> = .init()
    }
    
    public struct Output {
        let endLottie: PublishSubject<Void> = .init()
        let appCheckReesult: PublishSubject<Result<VersionCheckEntity,Error>> = .init()
        let userInfoResult: PublishSubject<VerifyEntity> = PublishSubject()
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.startLottie
            .delay(.seconds(2), scheduler: MainScheduler.instance) //TODO: 타임인터벌과 endLottie
            .bind(to: output.endLottie)
            .disposed(by: disposeBag)
        
        input.fetchVersionCheck
            .withUnretained(self)
            .flatMap({ (owner,_) -> Observable<VersionCheckEntity> in
                
                return owner.versionCheckUseCase
                    .execute(version: APP_VERSION())
                    .catch { error in
                        
                        return Single<VersionCheckEntity>.create { single in
                            single(.success(VersionCheckEntity(code: -1, statusCode: 400, message: "인터넷 연결이 오프라인입니다.\n네트워크 상태를 확인해주세요.")))
                            
                            return Disposables.create()
                        }
                    }
                    .asObservable()
            })
            .subscribe(onNext: { model in
                output.appCheckReesult.onNext(.success(model))
            },onError: { error in
                output.appCheckReesult.onNext(.failure(error))
            })
            .disposed(by: disposeBag)
        
        
        
        input.fetchUserCheck
            .withLatestFrom(PreferenceManager.$user)
            .filter({ userInfo in
               
                if userInfo == nil { // 현재 유저 정보가 없으면 , 그냥 통과 이므로 밑에 까지 내려갈 필요 없음
                    output.userInfoResult.onNext(VerifyEntity(isValid: true, statusCode: 200, message: ""))
                    return false
                }
                
                return true // 유저 정보 있으니 밑에 내려가서 검사 받아야함
               
            })
            .flatMap({ [weak self] _   -> Observable<VerifyEntity> in
                
                guard let self else { return Observable.empty()}
                
                return self.verifyUserUseCase
                    .execute()
                    .catchAndReturn(VerifyEntity(isValid: false, statusCode: 401, message: "인증이 만료되었습니다.\n다시 로그인해 주세요."))
                    .asObservable()
            })
            .bind(to: output.userInfoResult)
            .disposed(by: disposeBag)
        
        return output
    }
 
    
}
