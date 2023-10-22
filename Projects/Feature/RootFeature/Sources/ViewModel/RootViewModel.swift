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
    
    init(logOutUseCase: LogOutUseCase) {
        self.logOutUseCase = logOutUseCase
    }
    
    public struct Input {
        let viewDidLoad: PublishSubject<Void> = .init()
    }
    
    public struct Output {
        let moveMain: PublishSubject<Void> = .init()
    }
    
    
    public func transform(input: Input) -> Output {
        
        let output = Output()
        
        input.viewDidLoad
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                output.moveMain.onNext(())
            })
            .disposed(by: disposeBag)
        
        
        return output
    }
 
    
}
