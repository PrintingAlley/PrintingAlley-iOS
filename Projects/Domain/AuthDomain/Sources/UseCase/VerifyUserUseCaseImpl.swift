//
//  TestUseCaseImpl.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

import AuthDomainInterface
import RxSwift
import Network

struct VerifyUserUseCaseImpl: VerifyUserUseCase {

    

    private let authRepository: any AuthRepository

    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() -> RxSwift.Single<VerifyEntity> {
        authRepository.verify()
    }

}
