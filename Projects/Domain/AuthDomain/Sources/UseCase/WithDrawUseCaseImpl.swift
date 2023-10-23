//
//  WithDrawUseCaseImpl.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import AuthDomainInterface
import RxSwift
import Network
import BaseDomainInterface

struct WithDrawUseCaseImpl: WithDrawUseCase {

    

    private let authRepository: any AuthRepository

    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() -> Single<BaseEntity> {
        self.authRepository.withdraw()
    }
    

}
