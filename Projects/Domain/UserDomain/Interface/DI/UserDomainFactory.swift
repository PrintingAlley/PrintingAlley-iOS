//
//  UserDomainFactory.swift
//  UserDomainInterface
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

public protocol UserDomainFactory {
    var fetchUserInfoUseCase: any FetchUserInfoUseCase { get }
    var renameUserUseCase: any RenameUserUseCase { get }

    
}
