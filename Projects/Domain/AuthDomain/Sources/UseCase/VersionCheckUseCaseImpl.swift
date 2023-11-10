//
//  VersionCheckUseCaseImpl.swift
//  AuthDomain
//
//  Created by yongbeomkwak on 11/5/23.
//  Copyright © 2023 com. All rights reserved.
//

import AuthDomainInterface
import RxSwift
import Network
import BaseDomainInterface

struct VersionCheckUseCaseImpl: VersionCheckUseCase {

    

    private let authRepository: any AuthRepository

    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(version: String) -> Single<VersionCheckEntity> {
        self.authRepository.versionCheck(version: version)
    }
    

}
