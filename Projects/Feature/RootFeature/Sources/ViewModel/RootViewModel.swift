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
    
    init(logOutUseCase: LogOutUseCase,verifyUserUseCase: VerifyUserUseCase) {
        self.logOutUseCase = logOutUseCase
        self.verifyUserUseCase = verifyUserUseCase
    }
    
    public struct Input {
        let startLottie: PublishSubject<Void> = .init()
        let fetchAppCheck: PublishSubject<Void> = .init()
    }
    
    public struct Output {
        let endLottie: PublishSubject<Void> = .init()
        let moveMain: PublishSubject<Void> = .init()
        let fetchAppCheckReesult: PublishSubject<Void> = .init()
        let userInfoResult: PublishSubject<Result<String, Error>> = PublishSubject()
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.startLottie
            .delay(.seconds(2), scheduler: MainScheduler.instance) //TODO: 타임인터벌과 endLottie
            .subscribe(onNext: {
                output.moveMain.onNext(())
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
