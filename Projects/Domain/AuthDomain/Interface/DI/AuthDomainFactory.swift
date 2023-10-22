//
//  AuthDomainFactory.swift
//  AuthDomainInterface
//
//  Created by yongbeomkwak on 2023/10/09.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public protocol AuthDomainFactory {
    
    var fetchLoginUseCase: any FetchLoginUseCase { get }
    var fetchTokenTestUseCase: any FetchTokenTestUseCase { get }
    var logOutUseCase: any LogOutUseCase { get }
    var withDrawUseCase: any WithDrawUseCase { get }
}
