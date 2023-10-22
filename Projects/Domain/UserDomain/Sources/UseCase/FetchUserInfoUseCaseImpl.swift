//
//  FetchUserInfoUseCaseImpl.swift
//  UserDomain
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UserDomainInterface
import BaseDomainInterface
import RxSwift

struct FetchUserInfoUseCaseImpl: FetchUserInfoUseCase {
    
    private let userRepository: any UserRepository
    
    init(userRepository: any UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() -> Single<UserInfoEntity> {
        userRepository.fetchUserInfo()
    }
    
    
}



