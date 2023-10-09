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

struct TestGetUseCaseImpl: TestGetUseCase {

    private let authRepository: any AuthRepository

    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() -> Single<TestEntity> {
        authRepository.fetchTest()
    }
}
