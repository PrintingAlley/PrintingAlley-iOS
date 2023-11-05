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
        let moveMain: PublishSubject<Void> = .init()
        let appCheckReesult: PublishSubject<Result<VersionCheckEntity,Error>> = .init()
        let userInfoResult: PublishSubject<Result<String, Error>> = PublishSubject()
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
        

// 2.  앱체크
//        input.fetchAppCheck
//            .flatMap{
//                
//            }
        
        return output
    }
 
    
}
